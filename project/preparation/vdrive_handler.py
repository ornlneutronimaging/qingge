from collections import namedtuple
import os
import pandas as pd
import re


class VDriveHandler(object):

    Data = namedtuple('Data', ['raw', 'bank1', 'bank2', 'filename'])

    _raw_data = None
    _filename = ''

    def __init__(self):
        self._raw_data = None
        self._filename = ''

    def load_vdrive(self, filename=''):
        """load the VDrive file"""

        if filename == '':
            raise ValueError("Missing VDrive Filename")

        if not os.path.exists(filename):
            raise ValueError("File does not exist: {}".format(filename))

        self._filename = filename
        self._raw_data = pd.read_csv(filename,
                                     sep='\t',
                                     index_col=0)

    def keep_columns_of_interest(self):
        """We want to only keep the I/V and eI/V columns"""

        re_string = r'^I/V_\w*$'
        name_of_columns_to_keep = []
        full_list_name_of_columns = self._raw_data.columns.values
        pd_vdrive_raw_data = self._raw_data.copy()
        for _index, _label in enumerate(full_list_name_of_columns):
            m = re.match(re_string, _label)
            if m:
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index])
                name_of_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index + 1])

        self._data = pd_vdrive_raw_data.filter(name_of_columns_to_keep)

