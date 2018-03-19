import numpy as np
import os
import pandas as pd
import re


class Data(object):

    # pandas objects
    raw = None # just after loading the file
    raw_iv = None # just I/V columns data
    raw_eiv = None # just eI/V columns data
    cleaned = None  # only columns of interest
    bank1 = None # only data from bank1
    bank2 = None # only data from bank2

    filename = ''


class Bank(object):

    omega = []
    hrot = []
    psi = []
    phi = []

    iv = []
    eiv = []

    iv_mean_omega_45 = [] # mean of all omega=45 for iv
    eiv_mean_omega_45 = [] # mean of all omega=45 for eiv

    iv_stdev_omega_45 = [] # stdev of all omega=45 for iv
    eiv_stdev_omega_45 = [] # stdev of all omega=45 for eiv

    sin_omega = []

    table2 = [] # step before producing output table  iv table * sin(omega)
    iv_ratio_omega_90 = [] # uses when calculating bank2 table2


class VDriveHandler(object):

    def __init__(self):
        self.data = Data()
        self.bank1 = Bank()
        self.bank2 = Bank()

    def run(self):
        # full process
        self.initialize_bank_xaxis()
        self.keep_columns_of_interest()
        self.isolating_banks()
        self.calculate_mean_omega_45()
        self.calculate_sin_omega()
        # self.calculate_stdev_omega_45()  # not used for iv
        self.iv_sin()

    def calculate_sin_omega(self):
        """sin(Pi()/180 * omega
        this requires the initialize_bank_xaxis to be run before
        """

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

        [height, width] = np.shape(full_omega)
        new_dim = height * width
        
        self.bank2.omega = np.reshape(np.transpose(full_omega), new_dim, 1)
        self.bank2.hrot = np.reshape(np.transpose(full_hrot), new_dim, 1)
        self.bank2.psi = np.reshape(np.transpose(full_psi), new_dim, 1)
        self.bank2.phi = np.reshape(np.transpose(full_phi), new_dim, 1)

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

        [height, width] = np.shape(full_omega)
        new_dim = height * width

        self.bank1.omega = np.reshape(np.transpose(full_omega), new_dim, 1)
        self.bank1.hrot = np.reshape(np.transpose(full_hrot), new_dim, 1)
        self.bank1.psi = np.reshape(np.transpose(full_psi), new_dim, 1)
        self.bank1.phi = np.reshape(np.transpose(full_phi), new_dim, 1)

    def isolating_banks(self):
        _raw_data_iv = self.data.raw_iv
        _raw_data_eiv = self.data.raw_eiv

        bank1_string = r'^\w*/\w*_\w*_1$'
        bank2_string = r'^\w*/\w*_\w*_2$'

        # working with iv
        bank1_iv = []
        bank2_iv = []

        full_list_name_of_columns = self.data.raw_iv.columns.values
        for _label in full_list_name_of_columns:
            m_bank1 = re.match(bank1_string, _label)
            if m_bank1:
                bank1_iv.append(_label)
                continue

            m_bank2 = re.match(bank2_string, _label)
            if m_bank2:
                bank2_iv.append(_label)

        self.bank1.iv = _raw_data_iv.filter(bank1_iv)
        self.bank2.iv = _raw_data_iv.filter(bank2_iv)

        # working with iv
        bank1_eiv = []
        bank2_eiv = []

        full_list_name_of_columns = self.data.raw_eiv.columns.values
        for _label in full_list_name_of_columns:
            m_bank1 = re.match(bank1_string, _label)
            if m_bank1:
                bank1_eiv.append(_label)
                continue

            m_bank2 = re.match(bank2_string, _label)
            if m_bank2:
                bank2_eiv.append(_label)

        self.bank1.eiv = _raw_data_eiv.filter(bank1_eiv)
        self.bank2.eiv = _raw_data_eiv.filter(bank2_eiv)

    def calculate_mean_omega_45(self):
        """calculate the mean of all data sets for omega = 45 (only found in bank1)"""

        # iv
        iv_data = self.bank1.iv
        if len(iv_data) == 0:
            self.bank1.iv_mean_omega_45 = []
            return

        bank1_iv_omega_45 = np.array(iv_data)[0:12, :]
        self.bank1.iv_mean_omega_45 = np.mean(bank1_iv_omega_45, 0)

        # eiv
        eiv_data = self.bank1.eiv
        if len(eiv_data) == 0:
            self.bank1.eiv_mean_omega_45 = []
            return

        bank1_eiv_omega_45 = np.array(eiv_data)[0:12, :]
        self.bank1.eiv_mean_omega_45 = np.mean(bank1_eiv_omega_45, 0)

    def calculate_stdev_omega_45(self):
        """calculate std dev of all iv and eiv data for omega 45"""
        bank1_iv= self.bank1.iv
        if len(bank1_iv) == 0:
            self.bank1.iv_stdev_omega_45 = []
            return

        bank1_iv_omega_45 = np.array(bank1_iv)[0:12, :]
        self.bank1.iv_stdev_omega_45 = np.std(bank1_iv_omega_45, 0, ddof=1)

        # bank1_eiv = self.bank1.eiv
        # if len(bank1_eiv) == 0:
        #     self.bank1.eiv_stdev_omega_45 = []
        #     return
        #
        # bank1_eiv_omega_45 = np.array(bank1_eiv)[0:12, :]
        # self.bank1.eiv_stdev_omega_45 = np.std(bank1_eiv_omega_45, 0, ddof=1)

    def keep_columns_of_interest(self):
        """We want to only keep the I/V and eI/V columns"""
        re_string = r'^I/V_\w*$'
        name_of_iv_columns_to_keep = []
        name_of_eiv_columns_to_keep = []

        full_list_name_of_columns = self.data.raw.columns.values
        pd_vdrive_raw_data = self.data.raw.copy()
        for _index, _label in enumerate(full_list_name_of_columns):
            m = re.match(re_string, _label)
            if m:
                name_of_iv_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index])
                name_of_eiv_columns_to_keep.append(pd_vdrive_raw_data.columns.values[_index + 1])

        self.data.raw_iv = pd_vdrive_raw_data.filter(name_of_iv_columns_to_keep)
        self.data.raw_eiv = pd_vdrive_raw_data.filter(name_of_eiv_columns_to_keep)

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

    def calculate_bank2_iv_ratio_omega_90(self):
        """this ratio will be used in the iv_sin calculation"""

        # banks iv
        bank1_iv = np.array(self.bank1.iv)
        bank2_iv = np.array(self.bank2.iv)

        [nbr_row, nbr_column] = np.shape(bank1_iv)

        _iv_ratio_omega_90 = []
        for _row in np.arange(nbr_row - 12, nbr_row-6):
            _iv_n = bank2_iv[_row, :]
            _iv_d = bank1_iv[_row+6, :]
            _iv_ratio_omega_90.append(_iv_n/_iv_d)

        for _row in np.arange(nbr_row-6, nbr_row):
            _iv_n = bank2_iv[_row, :]
            _iv_d = bank1_iv[_row-6, :]
            _iv_ratio_omega_90.append(_iv_n/_iv_d)

        self.bank2.iv_ratio_omega_90 = np.array(_iv_ratio_omega_90)

    def calculata_table2(self):
        """calculate   sin(omega) * iv"""

        # banks iv
        bank1_iv = np.array(self.bank1.iv)
        bank2_iv = np.array(self.bank2.iv)

        # working with bank1
        bank1_iv_mean_omega_45 = self.bank1.iv_mean_omega_45
        bank1_sin_omega = self.bank1.sin_omega

        [nbr_row, nbr_column] = np.shape(bank1_iv)
        bank1_table2 = np.empty((nbr_row, nbr_column))
        bank1_table2[:] = np.NaN

        # special case for psi = 0
        for _column in np.arange(nbr_column):
            bank1_table2[0, _column] = bank1_sin_omega[0] * bank1_iv_mean_omega_45[_column]

        # then from index = 12 to before last 12, normal case
        for _column in np.arange(nbr_column):
            for _row in np.arange(12, nbr_row-12):
                sin_omega = bank1_sin_omega[_row]
                iv = bank1_iv[_row, _column]
                bank1_table2[_row, _column] = sin_omega * iv

        for _column in np.arange(nbr_column):
            for _row in np.arange(nbr_row-12, nbr_row-6):
                _array_to_mean = [bank1_iv[_row, _column], bank2_iv[_row+6, _column]]
                bank1_table2[_row, _column] = np.mean(_array_to_mean)

            for _row in np.arange(nbr_row-6, nbr_row):
                _array_to_mean = [bank1_iv[_row, _column], bank2_iv[_row-6, _column]]
                bank1_table2[_row, _column] = np.mean(_array_to_mean)

        self.bank1.table2 = bank1_table2

        # # working with bank2
        # bank2_iv = np.array(self.bank2.iv)
        # bank2_sin_omega = self.bank2.sin_omega
        #
        # [nbr_row, nbr_column] = np.shape(bank1_iv)
        # bank2_iv_sin = np.empty((nbr_row, nbr_column))
        # bank2_iv_sin[:] = np.NaN
        #
        # for _column in np.arange(nbr_column):
        #     for _row in np.arange(nbr_row):
        #         sin_omega = bank2_sin_omega[_row]
        #         iv = bank2_iv[_row, _column]
        #         bank2_iv_sin[_row, _column] = sin_omega * iv
        #         if _column ==0:
        #             print("bank2_iv_sin[{}: {}".format(_row, sin_omega*iv))
        #
        # self.bank2.iv_sin = bank2_iv_sin




