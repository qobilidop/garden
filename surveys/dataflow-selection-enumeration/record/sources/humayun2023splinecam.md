# humayun2023splinecam — SplineCam

- **Status:** deep-read
- **Primary source:** https://openaccess.thecvf.com/content/CVPR2023/html/Humayun_SplineCam_Exact_Visualization_and_Characterization_of_Deep_Network_Geometry_and_CVPR_2023_paper.html
- **Bibliography key:** `humayun2023splinecam`

## Result and scope

SplineCam constructs a bounded two-dimensional partition exact up to machine
precision and attaches per-region affine functions (proceedings pp.
3790--3792). Algorithm 1 constructs line arrangements and the layerwise method
back-projects them to the final partition.

Its supported CPWL vocabulary includes leaky ReLU, absolute value, maxout,
max-pooling, convolution, and skip connections. Theorem 1 concerns decision
boundaries after regions and maps exist; it is not an enumeration-completeness
theorem. The two-dimensional restriction prevents a direct general reduction,
but heterogeneous CPWL breadth is not novel.
