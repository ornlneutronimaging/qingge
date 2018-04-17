import unittest
import os
import numpy as np
import pprint
import re
import shutil
import pandas as pd

from project.preparation.vdrive_to_mtex import VdriveToMtex


class TestVDriveToMtexHandler(unittest.TestCase):

    def setUp(self):
        _file_path = os.path.dirname(__file__)
        self.data_path = os.path.abspath(os.path.join(_file_path,
                                                      '../../data/'))
        self.export_folder = self.data_path + '/temporary_folder/'
        self.input_filename = os.path.join(self.data_path, 'my_ducu.txt')
        # os.mkdir(self.export_folder)

        # max diff allowed to compare two arrays
        self.maxDiff = 0.000001

    def tearDown(self):
        # shutil.rmtree(self.export_folder)
        pass

    def test_input_file_mandatory(self):
        """assert error raised if input file missing or does not exist"""
        # no input file
        self.assertRaises(ValueError, VdriveToMtex)
        # file does not exist
        input_file = "i_do_not_exist"
        self.assertRaises(ValueError, VdriveToMtex, input_file)

    def test_loading_data(self):
        """assert data are correctly loaded, and just as they are, raw"""
        input_file = self.input_filename
        o_handler = VdriveToMtex(vdrive_handler_file=input_file)
        o_handler.load()

        raw_data = o_handler.raw_data
        expected_shape = (217, 12)
        returned_shape = np.shape(raw_data)

        self.assertEqual(expected_shape, returned_shape)

    def test_sorting_data(self):
        """assert the data are sorted using ascending psi and phi"""
        input_file = self.input_filename
        o_handler = VdriveToMtex(vdrive_handler_file=input_file)
        o_handler.load()
        o_handler.sort_raw_data()

        data_sorted = o_handler.raw_data_sorted
        psi_column = np.array(data_sorted['#psi'])
        phi_column = np.array(data_sorted['phi'])

        expected_phi_column = np.array([0, 0, 30, 60, 90, 120, 150])
        returned_phi_column = phi_column[0: 7]
        self.assertTrue((expected_phi_column == returned_phi_column).all())

        expected_psi_column = np.array([0, 5, 5, 5, 5, 5, 5])
        returned_psi_column = psi_column[0: 7]
        self.assertTrue((expected_psi_column == returned_psi_column).all())

    def test_axxx_arrays(self):
        """assert the a111, a200, a220 a311 and a222 are correctly defined"""
        input_file = self.input_filename
        o_handler = VdriveToMtex(vdrive_handler_file=input_file)
        o_handler.load()
        o_handler.sort_raw_data()

        a111 = o_handler.a111

        # psi and phi == 0
        a111_expected = np.zeros((12, 19))
        a111_expected[0, :] = 0.81264008

        for _returned, _expected in zip(a111[0, :], a111_expected[0, :]):
            self.assertAlmostEqual(_returned, _expected, delta=self.maxDiff)


