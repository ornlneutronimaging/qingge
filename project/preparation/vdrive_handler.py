import os
import pandas as pd


class VDriveHandler(object):

    vdrive_filename = ''

    def __init__(self):
        pass

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
        self.vdrive_raw_data = vdrive_raw_data
