import unittest
import os
import numpy as np

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
        return_vdrive_raw_data = o_vdrive.vdrive_raw_data

        # checking index (list of runs)
        expected_runs_0_10 = list(np.arange(78901.0, 78910.0))
        returned_runs_0_10 = list(return_vdrive_raw_data.index[0:9])
        self.assertEqual(expected_runs_0_10, returned_runs_0_10)

        # checking column 2
        # expected_data_col2 = list_
        returned_data_col2 = list(return_vdrive_raw_data.column[2])


