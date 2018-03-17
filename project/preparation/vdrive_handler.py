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
    data_min_omega_45 = [] #min of all omega=45

    sin_omega = []


class VDriveHandler(object):

    def __init__(self):
        self.data = Data()
        self.bank1 = Bank()
        self.bank2 = Bank()

    def calculate_sin_omega(self):
        """sin(Pi()/180 * omega"""

        #bank1
        bank1_omega = self.bank1.omega
        bank1_omega_rad = np.radians(bank1_omega)
        bank1_sin_omega = np.sin(bank1_omega_rad)
        self.bank1.sin_omega = bank1_sin_omega

        # bank2
        bank2_omega = self.bank2.omega
        bank2_omega_rad = np.radians(bank2_omega)
        bank2_sin_omega = np.sin(bank2_omega_rad)
        self.bank2.sin_omega = bank2_sin_omega

    def initialize_bank_xaxis(self):
        self.initialize_bank1_xaxis()
        self.initialize_bank2_xaxis()

    def initialize_bank2_xaxis(self):
        # initialization
        omega = [np.int(_value) for _value in np.ones(12) * 45]

        hrot1 = np.arange(0, 331, 30)
        hrot2 = hrot1[::-1]

        psi_init = np.ones(12) * 90
        psi = [np.int(_value) for _value in psi_init]

        phia = np.arange(180, -1, -30)
        phib = np.arange(330, 180, -30)
        phi1 = list(phia) + list(phib)
        phi2 = phi1[::-1]

        # full definition
        full_omega = []
        full_hrot = []
        full_psi = []
        full_phi = []

        omega_offset = np.arange(0, 46, 5)
        for _offset in omega_offset:
            full_omega.append(omega + _offset)

        hrot_offset = 0
        while (hrot_offset < 5):
            full_hrot.append(hrot1)
            full_hrot.append(hrot2)
            hrot_offset += 1

        psi_offset = np.arange(0, 46, 5)
        for _offset in psi_offset:
            full_psi.append(psi - _offset)

        phi_offset = 0
        while (phi_offset < 5):
            full_phi.append(phi1)
            full_phi.append(phi2)
            phi_offset += 1

        self.bank2.omega = np.reshape(np.transpose(full_omega), 120, 1)
        self.bank2.hrot = np.reshape(np.transpose(full_hrot), 120, 1)
        self.bank2.psi = np.reshape(np.transpose(full_psi), 120, 1)
        self.bank2.phi = np.reshape(np.transpose(full_phi), 120, 1)

    def initialize_bank1_xaxis(self):
        # initialization
        omega = [np.int(_value) for _value in np.ones(12)*45]

        psi = [np.int(_value) for _value in np.zeros(12)]

        hrot1 = np.arange(0, 331, 30)
        hrot2 = hrot1[::-1]

        phi1 = [0] + list(np.arange(330, 0, -30))
        phi2 = phi1[::-1]

        full_omega = []
        full_hrot = []
        full_psi = []
        full_phi = []

        # full definition
        omega_offset = np.arange(0, 46, 5)
        for _offset in omega_offset:
            full_omega.append(omega + _offset)
            full_psi.append(psi + _offset)

        _index = 0
        while (_index < 46):
            full_hrot.append(hrot1)
            full_phi.append(phi1)

            full_hrot.append(hrot2)
            full_phi.append(phi2)

            _index += 10

        self.bank1.omega = np.reshape(np.transpose(full_omega), 120, 1)
        self.bank1.hrot = np.reshape(np.transpose(full_hrot), 120, 1)
        self.bank1.psi = np.reshape(np.transpose(full_psi), 120, 1)
        self.bank1.phi = np.reshape(np.transpose(full_phi), 120, 1)

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

    def calculating_mean_omega_45(self):
        """calculate the mean of all data sets for omega = 45"""
        # bank1
        bank1_data = self.bank1.data
        if len(bank1_data) == 0:
            self.bank1.data_min_omega_45 = []
            self.bank2.data_min_omega_45 = []
            return

        bank1_omega_45 = bank1_data[0:12, :]
        print(np.shape(bank1_omega_45))
        # bank1_mean_omega_45 = np.mean(bank1_data[0: 12])
        # print(np.shape(bank1_mean_omega_45))



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
