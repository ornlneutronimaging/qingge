import unittest
import os
import numpy as np
import pprint
import re

from project.preparation.vdrive_handler import VDriveHandler


class TestVDriveHandler(unittest.TestCase):

    def setUp(self):
        _file_path = os.path.dirname(__file__)
        self.data_path = os.path.abspath(os.path.join(_file_path,
                                                      '../../data/'))
        self.filename = os.path.join(self.data_path, 'vdrive_filename.txt')

        # max diff allowed to compare two arrays
        self.maxDiff = 0.000001

    def test_vdrive_input_filename_should_not_be_empty(self):
        """assert VDrive filename should not be empty"""
        o_vdrive = VDriveHandler()
        self.assertRaises(ValueError, o_vdrive.load_vdrive)

    def test_vdrive_input_filename_should_exists(self):
        """assert error is raised when VDrive filename does not exists"""
        vdrive_file = 'do_not_exist.txt'
        o_vdrive = VDriveHandler()
        self.assertRaises(ValueError, o_vdrive.load_vdrive, vdrive_file)

    def test_vdrive_correctly_loaded(self):
        """assert raw VDrive file is correctly loaded"""
        filename = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=filename)
        filename_saved = o_vdrive.data.filename
        self.assertEqual(filename_saved, filename)

        _data = o_vdrive.data.raw
        first_runs = list(_data.index[0:9])
        first_runs_expected = list(np.arange(78901.0, 78910.0))
        self.assertEqual(first_runs_expected, first_runs)

    def test_keep_columns_of_interest(self):
        """assert vdrive data keeps only the columns of interest (I/V and eI/V)"""
        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()

        pd_vdrive_data_iv = o_vdrive.data.raw_iv
        pd_vdrive_data_eiv = o_vdrive.data.raw_eiv

        list_name_of_iv_columns = pd_vdrive_data_iv.columns.values
        list_name_of_eiv_columns = pd_vdrive_data_eiv.columns.values

        # make sure all the columns are iv or eiv
        number_of_iv_columns = 0
        number_of_eiv_columns = 0

        iv_re_string = r'^I/V_\w*$'
        for _index, _label in enumerate(list_name_of_iv_columns):
            m_iv = re.match(iv_re_string, _label)
            if m_iv:
                number_of_iv_columns += 1
        self.assertEqual(number_of_iv_columns, len(list_name_of_iv_columns))

        eiv_re_string = r'^eI/V_\w*$'
        for _index, _label in enumerate(list_name_of_eiv_columns):
            m_eiv = re.match(eiv_re_string, _label)
            if m_eiv:
                number_of_eiv_columns += 1
        self.assertEqual(number_of_eiv_columns, len(list_name_of_eiv_columns))

    def test_isolating_banks(self):
        """assert bank1 and bank2 data are correctly isolated"""
        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        o_vdrive.isolating_banks()

        # bank1
        bank1_iv_columns_values = o_vdrive.bank1.iv.columns.values
        bank1_iv_columns_expected = ['I/V_Ni111_1',
                                     'I/V_Ni200_1',
                                     'I/V_Ni220_1',
                                     'I/V_Ni311_1',
                                     'I/V_Ni222_1',
                                     'I/V_Ni400_1']
        self.assertTrue((bank1_iv_columns_values[0:6] == bank1_iv_columns_expected).all())

        bank1_eiv_columns_values = o_vdrive.bank1.eiv.columns.values
        bank1_eiv_columns_expected = ['eI/V_Ni111_1',
                                      'eI/V_Ni200_1',
                                      'eI/V_Ni220_1',
                                      'eI/V_Ni311_1',
                                      'eI/V_Ni222_1',
                                      'eI/V_Ni400_1']
        self.assertTrue((bank1_eiv_columns_values[0:6] == bank1_eiv_columns_expected).all())

        # bank2
        bank2_iv_columns_values = o_vdrive.bank2.iv.columns.values
        bank2_iv_columns_expected = ['I/V_Ni111_2',
                                     'I/V_Ni200_2',
                                     'I/V_Ni220_2',
                                     'I/V_Ni311_2',
                                     'I/V_Ni222_2',
                                     'I/V_Ni400_2']
        self.assertTrue((bank2_iv_columns_values[0:6] == bank2_iv_columns_expected).all())

        bank2_eiv_columns_values = o_vdrive.bank2.eiv.columns.values
        bank2_eiv_columns_expected = ['eI/V_Ni111_2',
                                      'eI/V_Ni200_2',
                                      'eI/V_Ni220_2',
                                      'eI/V_Ni311_2',
                                      'eI/V_Ni222_2',
                                      'eI/V_Ni400_2']
        self.assertTrue((bank2_eiv_columns_values[0:6] == bank2_eiv_columns_expected).all())

    def test_bank1_axis_initialization(self):
        """assert bank1 hrot, omega, psi and phi are correctly created"""
        o_vdrive = VDriveHandler()
        o_vdrive.initialize_bank1_xaxis()
        index_tested = [0, 5, 12, 19, 24, 36, 49, 67, 79, 89, 101, 111]

        omega_created = o_vdrive.bank1.omega
        omega_expected = [45, 45, 50, 50, 55, 60, 65, 70, 75, 80, 85, 90]
        omega_returned = [omega_created[_index] for _index in index_tested]
        self.assertEqual(omega_expected, omega_returned)

        hrot_created = o_vdrive.bank1.hrot
        hrot_expected = [0, 150, 330, 120, 0, 330, 30, 120, 210, 180, 150, 240]
        hrot_returned = [hrot_created[_index] for _index in index_tested]
        self.assertEqual(hrot_expected, hrot_returned)

        psi_created = o_vdrive.bank1.psi
        psi_expected = [0, 0, 5, 5, 10, 15, 20, 25, 30, 35, 40, 45]
        psi_returned = [psi_created[_index] for _index in index_tested]
        self.assertEqual(psi_expected, psi_returned)

        phi_created = o_vdrive.bank1.phi
        phi_expected = [0, 210, 30, 240, 0, 30, 330, 240, 150, 180, 210, 120]
        phi_returned = [phi_created[_index] for _index in index_tested]
        self.assertEqual(phi_expected, phi_returned)

    def test_bank2_axis_initialization(self):
        """assert bank2 omega, hrot, psi and phi are correctly created"""
        o_vdrive = VDriveHandler()
        o_vdrive.initialize_bank2_xaxis()
        index_tested = [0, 5, 12, 19, 24, 36, 49, 67, 79, 89, 101, 111]

        omega_created = o_vdrive.bank2.omega
        omega_expected = [45, 45, 50, 50, 55, 60, 65, 70, 75, 80, 85, 90]
        omega_returned = [omega_created[_index] for _index in index_tested]
        self.assertEqual(omega_expected, omega_returned)

        hrot_created = o_vdrive.bank2.hrot
        hrot_expected = [0, 150, 330, 120, 0, 330, 30, 120, 210, 180, 150, 240]
        hrot_returned = [hrot_created[_index] for _index in index_tested]
        self.assertEqual(hrot_expected, hrot_returned)

        psi_created = o_vdrive.bank2.psi
        psi_expected = [90, 90, 85, 85, 80, 75, 70, 65, 60, 55, 50, 45]
        psi_returned = [psi_created[_index] for _index in index_tested]
        self.assertEqual(psi_expected, psi_returned)

        phi_created = o_vdrive.bank2.phi
        phi_expected = [180, 30, 210, 60, 180, 210, 150, 60, 330, 0, 30, 300]
        phi_returned = [phi_created[_index] for _index in index_tested]
        self.assertEqual(phi_expected, phi_returned)

    def test_bank_axis_initialization(self):
        """assert bank1 and bank2 axis are correctly created"""
        o_vdrive = VDriveHandler()
        o_vdrive.initialize_bank_xaxis()

        # bank1
        index_tested = [0, 5, 12, 19, 24, 36, 49, 67, 79, 89, 101, 111]
        omega_created = o_vdrive.bank1.omega
        omega_expected = [45, 45, 50, 50, 55, 60, 65, 70, 75, 80, 85, 90]
        omega_returned = [omega_created[_index] for _index in index_tested]
        self.assertEqual(omega_expected, omega_returned)

        hrot_created = o_vdrive.bank1.hrot
        hrot_expected = [0, 150, 330, 120, 0, 330, 30, 120, 210, 180, 150, 240]
        hrot_returned = [hrot_created[_index] for _index in index_tested]
        self.assertEqual(hrot_expected, hrot_returned)

        psi_created = o_vdrive.bank1.psi
        psi_expected = [0, 0, 5, 5, 10, 15, 20, 25, 30, 35, 40, 45]
        psi_returned = [psi_created[_index] for _index in index_tested]
        self.assertEqual(psi_expected, psi_returned)

        phi_created = o_vdrive.bank1.phi
        phi_expected = [0, 210, 30, 240, 0, 30, 330, 240, 150, 180, 210, 120]
        phi_returned = [phi_created[_index] for _index in index_tested]
        self.assertEqual(phi_expected, phi_returned)

        # bank2
        omega_created = o_vdrive.bank2.omega
        omega_expected = [45, 45, 50, 50, 55, 60, 65, 70, 75, 80, 85, 90]
        omega_returned = [omega_created[_index] for _index in index_tested]
        self.assertEqual(omega_expected, omega_returned)

        hrot_created = o_vdrive.bank2.hrot
        hrot_expected = [0, 150, 330, 120, 0, 330, 30, 120, 210, 180, 150, 240]
        hrot_returned = [hrot_created[_index] for _index in index_tested]
        self.assertEqual(hrot_expected, hrot_returned)

        psi_created = o_vdrive.bank2.psi
        psi_expected = [90, 90, 85, 85, 80, 75, 70, 65, 60, 55, 50, 45]
        psi_returned = [psi_created[_index] for _index in index_tested]
        self.assertEqual(psi_expected, psi_returned)

        phi_created = o_vdrive.bank2.phi
        phi_expected = [180, 30, 210, 60, 180, 210, 150, 60, 330, 0, 30, 300]
        phi_returned = [phi_created[_index] for _index in index_tested]
        self.assertEqual(phi_expected, phi_returned)

    def test_sin_omega(self):
        """assert sin omega is working"""
        o_vdrive = VDriveHandler()
        o_vdrive.initialize_bank_xaxis()
        o_vdrive.calculate_sin_omega()

        # bank1
        sin_omega_bank1_returned = o_vdrive.bank1.sin_omega
        omega_bank1 = o_vdrive.bank1.omega
        sin_omega_bank1_expected = [np.sin(np.pi*_omega/180.) for _omega in omega_bank1]
        self.assertTrue((sin_omega_bank1_expected == sin_omega_bank1_returned).all())

        # bank2
        sin_omega_bank2_returned = o_vdrive.bank2.sin_omega
        omega_bank2 = o_vdrive.bank2.omega
        sin_omega_bank2_expected = [np.sin(np.pi*_omega/180.) for _omega in omega_bank2]
        self.assertTrue((sin_omega_bank2_expected == sin_omega_bank2_returned).all())

    def test_mean_omega_45(self):
        """assert mean omega 45 works correctly"""
        o_vdrive = VDriveHandler()
        o_vdrive.calculating_mean_omega_45()
        self.assertEqual(o_vdrive.bank1.data_mean_omega_45, [])

        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        o_vdrive.isolating_banks()
        o_vdrive.calculating_mean_omega_45()

        mean_omega_45_returned = o_vdrive.bank1.data_mean_omega_45
        mean_omega_45_expected = [2.451589167, 0.054312417, 2.399450833,
                                  0.053232583, 0.841268417, 0.01754925]

        _returned_expected = zip(mean_omega_45_expected[0:6], mean_omega_45_returned)
        for _returned, _expected in _returned_expected:
            self.assertAlmostEqual(_returned, _expected, delta=self.maxDiff)

    def test_stdev_omega_45(self):
        """assert std dev omega 45 works correctly"""
        o_vdrive = VDriveHandler()
        o_vdrive.calculating_stdev_omega_45()
        self.assertEqual(o_vdrive.bank1.data_stdev_omega_45, [])

        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        o_vdrive.isolating_banks()
        o_vdrive.calculating_stdev_omega_45()

        std_omega_45_returned = o_vdrive.bank1.data_stdev_omega_45
        std_omega_45_expected = [0.26040127, 0.00570957, 0.33226091,
                                 0.00823368, 0.05788931, 0.00171215]

        _returned_expected = zip(std_omega_45_returned[0:6], std_omega_45_expected)
        for _returned, _expected in _returned_expected:
            self.assertAlmostEqual(_returned, _expected, delta=self.maxDiff)

