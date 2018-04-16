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
        self.input_filename = os.path.join(self.data_path, 'ducu.txt')
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

        raw_data = o_handler.raw_input_data
        expected_shape = (217, 12)
        returned_shape = np.shape(raw_data)

        self.assertEqual(expected_shape, returned_shape)