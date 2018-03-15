from collections import namedtuple
import os
import pandas as pd
import re


class Data(object):

    # pandas objects
    raw = None # just after loading the file
    cleaned = None  # only columns of interest
    bank1 = None
    bank2 = None

    filename = ''


class VDriveHandler(object):

    def __init__(self):
        self.data = Data()

    def isolating_banks(self):
        _raw_data = self.data.raw

        bank1_string = r'^\w*/\w*_\w*_1$'
        bank2_string = r'^\w*/\w*_\w*_2$'

        bank1_columns = []
        bank2_columns = []

        full_list_name_of_columns = self.data.raw.columns.values
        for _label in full_list_name_of_columns:
            m_bank1 = re.match(bank1_string, _label)
            if m_bank1:
                bank1_columns.append(_label)
                continue

            m_bank2 = re.match(bank2_string, _label)
            if m_bank2:
                bank2_columns.append(_label)

        self.data.bank1 = _raw_data.filter(bank1_columns)
        self.data.bank2 = _raw_data.filter(bank2_columns)

    def keep_columns_of_interest(self):
        """We want to only keep the I/V and eI/V columns"""
        re_string = r'^I/V_\w*$'
        name_of_columns_to_keep = []
        full_list_name_of_columns = self.data.raw.columns.values
        pd_vdrive_raw_data = self.data.raw.copy()
        for _index, _label in enumerate(full_list_name_of_columns):
            m = re.match(re_string, _label)
            if m:
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index])
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index + 1])

        self.data.raw = pd_vdrive_raw_data.filter(name_of_columns_to_keep)

    def load_vdrive(self, filename=''):
        """load the VDrive file"""

        if filename == '':
            raise ValueError("Missing VDrive Filename")

        if not os.path.exists(filename):
            raise ValueError("File does not exist: {}".format(filename))

        self.data.filename = filename
        self.data.raw = pd.read_csv(filename,
                                     sep='\t',
                                     index_col=0)
