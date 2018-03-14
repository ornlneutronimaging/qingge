from collections import namedtuple
import os
import pandas as pd
import re


class VDriveHandler(object):

    RawBank1 = namedtuple('RawBank1', ['filename', 'data'])
    RawBank2 = namedtuple('RawBank2', ['filename', 'data'])

    def __init__(self):
        pass

    def load_vdrive(self, filename='', bank=1):
        """load the VDrive file"""

        if filename == '':
            raise ValueError("Missing VDrive Filename")

        if not os.path.exists(filename):
            raise ValueError("File does not exist: {}".format(filename))

        if not bank in [1, 2]:
            raise ValueError("Bank {} is not implemented!".format(bank))


        _raw_data = pd.read_csv(filename,
                                sep='\t',
                               index_col=0)

        if bank == 1:
            self.raw_bank1 = self.RawBank1(filename=filename,
                                      data=_raw_data)
        else:
            self.raw_bank1 = self.RawBank1(filename=filename,
                                         data=_raw_data)


    def keep_columns_of_interest(self):
        """We want to only keep the I/V and eI/V columns"""

        re_string = r'^I/V_\w*$'
        name_of_columns_to_keep = []
        full_list_name_of_columns = self.pd_vdrive_raw_data.columns.values
        pd_vdrive_raw_data = self.pd_vdrive_raw_data.copy()
        for _index, _label in enumerate(full_list_name_of_columns):
            m = re.match(re_string, _label)
            if m:
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index])
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index + 1])

        self.pd_vdrive_data = pd_vdrive_raw_data.filter(name_of_columns_to_keep)

