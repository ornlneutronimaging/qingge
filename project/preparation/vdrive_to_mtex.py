import numpy as np
import os
import pandas as pd


class VdriveToMtex(object):

    vdrive_handler_file = ''  # name of input file (produced by vdrive_handler.py
    raw_data = []
    raw_data_sorted = []

    a111 = np.zeros((19, 12))
    a200 = np.zeros((19, 12))
    a220 = np.zeros((19, 12))
    a311 = np.zeros((19, 12))
    a222 = np.zeros((19, 12))

    psi = np.arange(0, 91, 5)
    phi = np.arange(0, 331, 30)

    def __init__(self, vdrive_handler_file=''):
        if vdrive_handler_file == '':
            raise ValueError("Please provide an input file (output of vdrive_handler.py")

        if not os.path.exists(vdrive_handler_file):
            raise ValueError("File does not exist ({})".format(vdrive_handler_file))

        self.vdrive_handler_file = vdrive_handler_file

    def load(self):
        vdrive_handler_file = self.vdrive_handler_file
        self.raw_data = pd.read_csv(vdrive_handler_file, sep=',')

    def sort_raw_data(self):
        """format the ducu.txt data

        only the first 7 columns of data will be used
        The data are sorted according to psi and then phi
        """
        raw_data_sorted = self.raw_data.sort_values(['#psi', 'phi'])
        self.raw_data_sorted = raw_data_sorted

        # get ride of first 2 columns (psi and phi
        clean_data_sorted = np.array(raw_data_sorted.drop(['#psi', 'phi'], axis=1))
        self.i_over_v_data_only = clean_data_sorted

        a111 = self.a111
        a200 = self.a200
        a220 = self.a220
        a311 = self.a311
        a222 = self.a222

        a111_flatten = a111.flatten()

        # special case for psi and phi = 0
        a111_flatten[0:12] = clean_data_sorted[0, 0]
        # a200[:, 0] = clean_data_sorted[0, 1]
        # a220[:, 0] = clean_data_sorted[0, 2]
        # a311[:, 0] = clean_data_sorted[0, 3]
        # a222[:, 0] = clean_data_sorted[0, 4]

        # all over psi and phi
        i_over_v_flatten_for_a111 = clean_data_sorted[:, 0].flatten()
        a111_flatten[12: ] = i_over_v_flatten_for_a111[1: ]

        a111 = np.reshape(a111_flatten, (19, 12))

        self.a111 = a111
        self.a200 = a200
        self.a220 = a220
        self.a311 = a311
        self.a222 = a222
