#!/bin/bash

ROOTDIR="."

convert_pdf_to_png() {
  local f
  local resolution
  f="${1}"
  resolution="${2:-3200}"
  echo "$f"
  echo "" | /bin/gs -dBATCH -sOutputFile="${f%*.pdf}".png -sDEVICE=png16m -r"${resolution}" -dDownScaleFactor=4 "$f"
}


convert_pdf_to_png "$ROOTDIR"/introduction/arch-overview-factorized.pdf                                 3200
convert_pdf_to_png "$ROOTDIR"/introduction/arch-overview-hyperprior.pdf                                 3200
convert_pdf_to_png "$ROOTDIR"/introduction/encoding-distribution.pdf                                    6400
convert_pdf_to_png "$ROOTDIR"/introduction/encoding-distributions-conditional.pdf                       3200
convert_pdf_to_png "$ROOTDIR"/introduction/encoding-distributions-factorized.pdf                        3200
convert_pdf_to_png "$ROOTDIR"/introduction/rd-curves-image-kodak-psnr-rgb.pdf                           3200

convert_pdf_to_png "$ROOTDIR"/pdf_compression/arch-both.pdf                                             3200
convert_pdf_to_png "$ROOTDIR"/pdf_compression/arch-hasq.pdf                                             3200
convert_pdf_to_png "$ROOTDIR"/pdf_compression/arch-overview.pdf                                         3200
convert_pdf_to_png "$ROOTDIR"/pdf_compression/encoding-distribution-amortized-optimality.pdf            3200
convert_pdf_to_png "$ROOTDIR"/pdf_compression/hist-kernels.pdf                                          3200
convert_pdf_to_png "$ROOTDIR"/pdf_compression/pdfs.pdf                                                  1600
convert_pdf_to_png "$ROOTDIR"/pdf_compression/pdfs1.pdf                                                 1600
convert_pdf_to_png "$ROOTDIR"/pdf_compression/pdfs2.pdf                                                 1600
convert_pdf_to_png "$ROOTDIR"/pdf_compression/pdfs3.pdf                                                 1600
convert_pdf_to_png "$ROOTDIR"/pdf_compression/rd-curves-kodak-psnr-bmshj2018-factorized.pdf             1600
convert_pdf_to_png "$ROOTDIR"/pdf_compression/simple-adaptive-pdf-arch.pdf                              3200

convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/arch/input-compression.pdf                        3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/arch/proposed-full.pdf                            3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/arch/proposed.pdf                                 3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/full_1.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/full_2.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/full_3.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/full_4.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/lite_1.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/lite_2.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/lite_3.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/lite_4.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/micro_1.pdf               1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/micro_2.pdf               1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/micro_3.pdf               1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/crit/test_airplane_0630/micro_4.pdf               1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rate_accuracy/modelnet40_full.pdf                 3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rate_accuracy/modelnet40_input-compression.pdf    3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rate_accuracy/modelnet40_lite.pdf                 3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rate_accuracy/modelnet40_micro.pdf                3200
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/full_1.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/full_2.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/full_3.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/full_4.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/lite_1.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/lite_2.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/lite_3.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/lite_4.pdf                 1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/micro_1.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/micro_2.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/micro_3.pdf                1600
convert_pdf_to_png "$ROOTDIR"/point_cloud_compression/rec/test_airplane_0630/micro_4.pdf                1600



