# Week 1 Progress Report
> Report generated by Claude Sonnet 4 with human proofreading and modifications.

**Timeline:** Week 1.5 of 9 weeks
**Date:** 25/May/2025

## Objectives Completed

### API Discovery and Documentation
Successfully reverse engineered the core API infrastructure of the Ho Chi Minh City bus transit website (buyttphcm.com.vn). Using browser developer tools to capture HTTP traffic for further analysis, four primary API endpoints has been identified and 2 has been fully documented:

1. **EBMS Bus Stop Discovery API** - Retrieves bus stops within geographic bounding boxes
2. **EBMS Route Pathfinding API** - Calculates possible bus routes between two points with transfer options
3. **STIS Map Tile Service** - Provides map visualization tiles
4. **Traffic Information API** - Walking route calculation (currently returning 404 errors)

#### Example API Endpoints Discovered

**Bus Stop Discovery (Geographic Bounding Box):**
```http
GET http://apicms.ebms.vn/businfo/getstopsinbounds/106.686/10.763/106.706/10.772
```
This retrieves all bus stops within a rectangle defined by:
- Lower-left corner: longitude 106.686, latitude 10.763
- Upper-right corner: longitude 106.706, latitude 10.772

**Route Pathfinding (Point-to-Point Journey Planning):**
```http
GET http://apicms.ebms.vn/pathfinding/getpathbystop/10.771,106.695/10.768,106.689/2
```
This calculates bus routes from coordinates (10.771, 106.695) to (10.768, 106.689) with maximum 2 transfers.

### Technical Documentation
Created comprehensive API specifications using Bruno format (.bru files) including:
- Complete request/response examples with real (truncated) data
- Field documentation and data type specifications
- Working parameter examples for immediate testing
- Error condition documentation

All documentation stored in `git/docs/reverse_engineering/` for team access.

## Technical Challenges and Solutions

### Tooling Evaluation
Evaluated multiple API documentation platforms (Insomnia, Bruno, etc.) for creating platform-agnostic API specifications. Initial attempts with graphical tools were time-consuming, I eventually just went with including the `.bru` files, which can be open using the bruno client.

### Data Structure Analysis
Successfully decoded complex response formats, particularly the EBMS pathfinding API which returns multi-leg journey plans with coordinate arrays for route visualization and is overall really, *Really* cursed.

## Next Week Priorities

1. **Phoenix Framework Setup** - Initialize Elixir/Phoenix project structure for the proxy application
2. **HTTP Client Implementation** - Develop Erlang HTTP client integration to interface with discovered APIs
3. **Thesis Documentation** - Set up LaTeX template on Overleaf and begin formal documentation

## Questions/Support Needed

None at this time. Clear path forward identified for next sprint cycle.
