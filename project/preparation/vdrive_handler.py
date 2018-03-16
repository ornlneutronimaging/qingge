import numpy as np
import os
import pandas as pd
import re


class Data(object):

    # pandas objects
    raw = None # just after loading the file
    cleaned = None  # only columns of interest
    bank1 = None # only data from bank1
    bank2 = None # only data from bank2

    filename = ''


class Bank(object):

    omega = []
    hrot = []
    psi = []
    phi = []

    data = []


class VDriveHandler(object):

    def __init__(self):
        self.data = Data()
        self.bank1 = Bank()
        self.bank2 = Bank()

    def initialize_xaxis(self):

        # bank1
        omega = np.arange(45, 95, 5)
        psi = np.arange(0, 50, 5)

        hrot1 = list(np.arange(0, 360, 30))
        hrot2 = hrot1[::-1]
        hrot = hrot1 + hrot2

        phi_1 = list(np.arange(330, 0, -30))
        phi_2 = phi_1[::-1]
        phi = [0] + list(phi_1) + list(phi_2) + [0]

        omega_psi = zip(omega, psi)
        hrot_phi = zip(hrot, phi)

        full_omega = []
        full_psi = []
        full_hrot = []
        full_phi = []

        for _omega, _psi in omega_psi:
            for _hrot, _phi in hrot_phi:
                full_omega.append(_omega)
                full_psi.append(_psi)
                full_hrot.append(_hrot)
                full_phi.append(_phi)

        self.bank1.omega = full_omega
        self.bank1.psi = full_psi
        self.bank1.hrot = full_hrot
        self.bank1.phi = full_phi

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

        self.bank1.data = _raw_data.filter(bank1_columns)
        self.bank2.data = _raw_data.filter(bank2_columns)

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
