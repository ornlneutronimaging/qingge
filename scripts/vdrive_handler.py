import argparse

from project.preparation.vdrive_handler import VDriveHandler

parser = argparse.ArgumentParser(description='VDrive File Handler')
parser.add_argument('-i', '--input', help='VDrive file', type=str)
parser.add_argument('-o', '--output', help='Output file', type=str)

def vdrive_handler():

    args = parser.parse_args()

    o_vdrive = VDriveHandler()
    o_vdrive.load_vdrive(filename = args.input)
    o_vdrive.run()
    o_vdrive.export_table(filename = args.output)

if __name__ == "__main__":
    vdrive_handler()