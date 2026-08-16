# Urban Wind Path Planning in Unknown Flow Fields

MATLAB code for the urban wind path-planning experiments described in the associated paper. The repository simulates an agent traversing an urban graph with unknown directed edge winds, reconstructs a latent temporal wind-driving signal from edge measurements, updates edge-wind estimates over repeated passes, and evaluates the resulting path-planning performance.

## Overview

The main workflow is:

1. Generate an urban graph and nominal directed wind field.
2. Generate a latent temporal wind-driving signal.
3. Repeatedly compute a minimum-time path using the current edge-cost estimate.
4. Simulate traversal of that path and collect edge-level wind measurements.
5. Stitch the measured edge segments into a reconstructed temporal driver.
6. Update directed edge-wind estimates from all traversed segments.
7. Compare estimated and realized path costs over successive passes.

The code is organized so that the main script drives the experiment and the supporting functions provide map generation, path planning, signal generation, signal stitching, and figure formatting.

## Files

### Main script
- `Main.mlx`  
  Runs the full sequential planning and estimation experiment. This is the script to execute first.

### Supporting functions
- `citymap.mlx`  
  Builds the urban graph, node coordinates, edge distances, and nominal directed wind matrix.

- `plotwindfield.mlx`  
  Visualizes the directed wind field on the graph.

- `windgen.mlx`  
  Generates the latent temporal driving signal and directional modulation used in the simulation.

- `Dijkstra.m`  
  Computes the current minimum-cost path on the directed graph.

- `crosswind.m`  
  Computes the crosswind correction used during edge traversal.

- `windstitch_optimizer.mlx`  
  Objective function used when optimizing the stitching parameters.

- `windrestitch.mlx`  
  Reconstructs the latent temporal signal by sequentially stitching fitted edge segments.

- `windstitch_variable.mlx`  
  Stitches one fitted edge segment onto the current reconstructed signal.

- `make_nice_figures.m`  
  Applies consistent figure formatting and optional export settings.

## MATLAB requirements

Tested in MATLAB with the following toolbox dependencies:

- Optimization Toolbox  
  Required for `fmincon` and `optimoptions`

- Statistics and Machine Learning Toolbox  
  Required for `normrnd` and `cdf`

If the code is run in a different MATLAB release, figure-formatting behavior and some plotting utilities may vary slightly.

## How to run

1. Place `Main.mlx` and all required `.mlx, .m` files in the same working directory or on the MATLAB path.
2. Open MATLAB in the repository root.
3. Edit any output filenames if figure export is desired.
4. Run `Main.mlx`.

## Output

Depending on which plotting and export lines are enabled, the code can produce figures showing:

- directed wind-field visualization
- convergence of the directed edge-wind estimate
- reconstructed versus true temporal driving signal
- reconstruction error over time
- realized versus expected path cost over repeated passes
- raw edge-level wind measurements

Diagnostic plots are intentionally retained in commented form in several functions.

## Notes on repository use

- Some filename variables are intentionally left as `'file'` and should be edited by the user before exporting figures.
- The code is written to preserve the implementation used for the paper rather than to provide a generalized software package.
- Several routines rely on shared conventions established by the main script, including the use of global metric storage during the stitching process.

## Reproducibility notes

To reproduce the paper results, keep the random seeds and problem parameters in `Main.mlx` unchanged unless a different case study is intended. In particular:

- the urban graph size
- the wind magnitude bound
- the vehicle speed
- the temporal signal parameters
- the number of sequential passes

Changing these values may alter both the planned paths and the reconstructed wind estimates.

## License

See `LICENSE.txt`.

## Authors

- Jeffrey DesRoches
- Raghvendra Cowlagi
