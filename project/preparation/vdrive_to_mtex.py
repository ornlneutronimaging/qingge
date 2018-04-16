import os
import pandas as pd


class VdriveToMtex(object):

    vdrive_handler_file = ''  # name of input file (produced by vdrive_handler.py
    raw_input_data = []

    def __init__(self, vdrive_handler_file=''):
        if vdrive_handler_file == '':
            raise ValueError("Please provide an input file (output of vdrive_handler.py")

        if not os.path.exists(vdrive_handler_file):
            raise ValueError("File does not exist ({})".format(vdrive_handler_file))

        self.vdrive_handler_file = vdrive_handler_file

    def load(self):
        vdrive_handler_file = self.vdrive_handler_file
        self.raw_input_data = pd.read_csv(vdrive_handler_file, sep='\t')
