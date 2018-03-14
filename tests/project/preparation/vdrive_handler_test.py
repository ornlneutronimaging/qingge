import unittest
import os
import numpy as np
import re

from project.preparation.vdrive_handler import VDriveHandler


class TestVDriveHandler(unittest.TestCase):

    def setUp(self):
        _file_path = os.path.dirname(__file__)
        self.data_path = os.path.abspath(os.path.join(_file_path,
                                                      '../../data/'))
        self.vdrive_filename = os.path.join(self.data_path, 'vdrive_filename.txt')

    def test_vdrive_input_filename_should_not_be_empty(self):
        """assert VDrive filename should not be empty"""
        o_vdrive = VDriveHandler()
        self.assertRaises(ValueError, o_vdrive.load_vdrive)

    def test_vdrive_input_filename_should_exists(self):
        """assert VDrive filename should exists"""
        vdrive_file = 'do_not_exist.txt'
        o_vdrive = VDriveHandler()
        self.assertRaises(ValueError, o_vdrive.load_vdrive, vdrive_file)

    def test_vdrive_correctly_loaded(self):
        """assert raw VDrive file is correctly loaded"""
        vdrive_file = self.vdrive_filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(vdrive_filename=vdrive_file)
        returned_vdrive_raw_data = o_vdrive.pd_vdrive_raw_data

        # checking index (list of runs)
        expected_runs_0_10 = list(np.arange(78901.0, 78910.0))
        returned_runs_0_10 = list(returned_vdrive_raw_data.index[0:9])
        self.assertEqual(expected_runs_0_10, returned_runs_0_10)

    def test_vdrive_data_correctly_cleaned(self):
        """assert vdrive data keeps only the columns of interest (I/V and eI/V)"""
        vdrive_file = self.vdrive_filename
        o_vdrive = VDriveHandler()
        o_vdrive.load_vdrive(vdrive_filename=vdrive_file)
        o_vdrive.keep_columns_of_interest()
        pd_vdrive_data = o_vdrive.pd_vdrive_data
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


