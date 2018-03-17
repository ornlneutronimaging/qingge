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
        pd_vdrive_data = o_vdrive.data.raw
        list_name_of_columns = pd_vdrive_data.columns.values

        # make sure there is a many IV as eIV columns
        number_of_IV_columns = 0
        number_of_eIV_columns = 0

        IV_re_string = r'^I/V_\w*$'
        eIV_re_string = r'^eI/V_\w*$'
        for _index, _label in enumerate(list_name_of_columns):
            m_IV = re.match(IV_re_string, _label)
            if m_IV:
                number_of_IV_columns += 1

            m_eIV = re.match(eIV_re_string, _label)
            if m_eIV:
                number_of_eIV_columns += 1

        self.assertEqual(number_of_eIV_columns, number_of_IV_columns)

    def test_isolating_banks(self):
        """assert bank1 and bank2 data are correctly isolated"""
        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        o_vdrive.isolating_banks()

        bank1_columns_values = o_vdrive.bank1.data.columns.values
        bank1_columns_expected = ['I/V_Ni111_1', 'eI/V_Ni111_1',
                                  'I/V_Ni200_1', 'eI/V_Ni200_1',
                                  'I/V_Ni220_1', 'eI/V_Ni220_1']
        self.assertTrue((bank1_columns_values[0:6] == bank1_columns_expected).all())

        bank2_columns_values = o_vdrive.bank2.data.columns.values
        bank2_columns_expected = ['I/V_Ni111_2', 'eI/V_Ni111_2',
                                  'I/V_Ni200_2', 'eI/V_Ni200_2',
                                  'I/V_Ni220_2', 'eI/V_Ni220_2']
        self.assertTrue((bank2_columns_values[0:6] == bank2_columns_expected).all())

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
        self.assertEqual(o_vdrive.bank1.data_min_omega_45, [])
        self.assertEqual(o_vdrive.bank2.data_min_omega_45, [])

        vdrive_file = self.filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        o_vdrive.isolating_banks()
        o_vdrive.calculating_mean_omega_45()
