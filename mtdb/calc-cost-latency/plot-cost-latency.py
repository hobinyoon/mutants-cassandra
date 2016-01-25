#!/usr/bin/env python

import sys

import Conf
import CassLogReader
import LoadgenLogReader
import Plot
import StorageSizeByTimePlotDataGenerator
import TabletAccessesTimelinePlotDataGenerator
import TabletMinMaxTimestampsTimelinePlotDataGenerator


def main(argv):
	Conf.Init()

	LoadgenLogReader.Read()
	LoadgenLogReader.GenLatencyPlotData()

	CassLogReader.Read()
	StorageSizeByTimePlotDataGenerator.Gen()
	TabletAccessesTimelinePlotDataGenerator.Gen()
	TabletMinMaxTimestampsTimelinePlotDataGenerator.Gen()

	Plot.Latency()
	Plot.StorageSize()
	Plot.TabletAccessesTimeline()
	Plot.TabletMinMaxTimestampsTimeline()


if __name__ == "__main__":
  sys.exit(main(sys.argv))
