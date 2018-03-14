import os
import pandas as pd
import re


class VDriveHandler(object):

    vdrive_filename = ''
    pd_vdrive_raw_data = None  # pandas object of raw data loaded
    pd_vdrive_data = None # pandas object of only columns of interest

    def __init__(self):
        self.vdrive_filename = ''
        self.pd_vdrive_raw_data = None
        self.pd_vdrive_data = None

    def load_vdrive(self, vdrive_filename=''):
        """load the VDrive file"""

        if vdrive_filename == '':
            raise ValueError("Missing VDrive Filename")

        if not os.path.exists(vdrive_filename):
            raise ValueError("File does not exist: {}".format(vdrive_filename))

        self.vdrive_filename = vdrive_filename

        vdrive_raw_data = pd.read_csv(vdrive_filename,
                               sep='\t',
                               index_col=0)
        self.pd_vdrive_raw_data = vdrive_raw_data

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

