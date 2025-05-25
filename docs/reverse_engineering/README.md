# API Endpoints Documentation

This document contains detailed API endpoint specifications for the Ho Chi Minh City bus transit system. The `.bru` files require Bruno client to open.

> This README is maintained by Claude 3.5 Haiku & Sonnet 4, with human oversight and correction

## 1. EBMS Bus Stop Discovery API

**URL:** `http://apicms.ebms.vn/businfo/getstopsinbounds/:lower_longtitude/:lower_latitude/:upper_longtitude/:upper_latitude`

### Parameters
| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `lower_longtitude` | Float | Lower longitude coordinate of bounding box | 106.68651666641236 |
| `lower_latitude` | Float | Lower latitude coordinate of bounding box | 10.763876057931437 |
| `upper_longtitude` | Float | Upper longitude coordinate of bounding box | 106.70655641555786 |
| `upper_latitude` | Float | Upper latitude coordinate of bounding box | 10.772645263811139 |

### Response Format
Returns a JSON array of bus stops within the specified geographic bounding box.

**Example Response:**
```json
[
  {
    "StopId": 25,
    "Code": "Q1 136",
    "Name": "Rạp Trần Hưng Đạo",
    "StopType": "Nhà chờ",
    "Zone": "Quận 1",
    "Ward": "Phường Cô Giang",
    "AddressNo": "227 - 229 (255)",
    "Street": "Trần Hưng Đạo",
    "SupportDisability": "",
    "Status": "Đang khai thác",
    "Lng": 106.692722,
    "Lat": 10.76483,
    "Search": "RTHD 227-229( THD",
    "Routes": "01, 139, 152"
  }
]
```

**Response Headers:**
```http
server: nginx/1.14.0 (Ubuntu)
date: Wed, 21 May 2025 12:58:16 GMT
content-type: application/json; charset=utf-8
content-length: 4551
connection: keep-alive
cache-control: no-cache
pragma: no-cache
expires: -1
access-control-allow-origin: http://buyttphcm.com.vn
x-aspnet-version: 4.0.30319
x-powered-by: ASP.NET
```

### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| StopId | Int | Unique stop identifier |
| Code | String | Stop code designation |
| Name | String | Human-readable stop name |
| StopType | String | Type of bus stop facility |
| Zone | String | Administrative zone/district |
| Ward | String | Administrative ward |
| AddressNo | String | Street address number |
| Street | String | Street name |
| SupportDisability | String | Disability accessibility information |
| Status | String | Operational status |
| Lng | Float | Longitude coordinate |
| Lat | Float | Latitude coordinate |
| Search | String | Search-optimized text |
| Routes | String | Comma-separated list of bus routes |

## 2. EBMS Route Pathfinding API

**URL:** `http://apicms.ebms.vn/pathfinding/getpathbystop/:start_pos/:end_pos/:number_of_stops`

### Parameters
| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `start_pos` | String | Starting coordinates (latitude,longitude) | 10.771464806250796,106.69524478918902 |
| `end_pos` | String | Destination coordinates (latitude,longitude) | 10.768850924804605,106.68900060660235 |
| `number_of_stops` | Integer | Maximum number of transfers allowed | 2 |

### Response Format
Returns a JSON array of possible bus routes from point A to B. Each route contains:

#### Route Structure
- **detail** array: Individual legs of the trip (walking + bus segments)
- **stops** array: Redundant coordinates of each point in the trip
- **coordRoute** object: Coordinate arrays for route visualization (cursed format)
- **Title**: Route summary
- **Desc**: Route description

#### Detail Array Fields
| Field | Data Type | Description |
|-------|-----------|-------------|
| ImageUrl | String or null | Image URL of transportation type (uses backslashes "\\") |
| RouteNo | String or null | Bus route number |
| EndStop | String or null | Readable final destination of the route |
| GetIn, GetOff | String | Description of boarding/alighting point (stop name with code or `[Tọa độ điểm...]`) |
| GetInLat | Number | Latitude of boarding location |
| GetInLng | Number | Longitude of boarding location |
| GetOffLat | Number | Latitude of alighting location |
| GetOffLng | Number | Longitude of alighting location |
| Halt | Number | Unknown purpose |
| Length | String (of number) | Bird's path distance between 2 points |
| Distance | String (of number) | Actual traversal distance |
| Fare | Number | Ticket price (in Vietnamese Dong) |

#### Stops Array Fields
| Field | Data Type | Description |
|-------|-----------|-------------|
| Name | String | Stop name or coordinate description |
| Lat | Float | Latitude coordinate |
| Lng | Float | Longitude coordinate |
| Type | Integer | `0` = starting location; `1` = bus stops; `-2` = destination |

#### CoordRoute Object
Contains arrays of coordinates for plotting bus routes. Each key follows the format:
`<Route_Number>_<Stop_Name_Start>_<Stop_Name_End>`

Each coordinate entry contains:
| Field | Data Type | Description |
|-------|-----------|-------------|
| Latitude | Float | Geographic latitude coordinates for route points |
| Longitude | Float | Geographic longitude coordinates for route points |

**Example Response:**
```json
[
  {
    "detail": [
      {
        "ImageUrl": "\\Assets\\Icon\\walk.png",
        "RouteNo": null,
        "EndStop": null,
        "GetIn": "[Tọa độ điểm xuất phát] ",
        "GetInLat": 10.771464347839355,
        "GetInLng": 106.69524383544922,
        "GetOff": "[Q1 187] Khách sạn New World",
        "GetOffLat": 10.770964,
        "GetOffLng": 106.695946,
        "Halt": 0,
        "Length": "68",
        "Distance": "95",
        "Fare": 0
      },
      {
        "ImageUrl": null,
        "RouteNo": "03",
        "EndStop": "Bến xe buýt Sài Gòn",
        "GetIn": "[Q1 187] Khách sạn New World",
        "GetInLat": 10.770964,
        "GetInLng": 106.695946,
        "GetOff": "[BX 01] Bến xe buýt Sài Gòn",
        "GetOffLat": 10.767676,
        "GetOffLng": 106.689362,
        "Halt": 0,
        "Length": "163",
        "Distance": "897",
        "Fare": 6000
      }
    ],
    "stops": [
      {
        "Name": "[Tọa độ điểm xuất phát] ",
        "Lat": 10.771464347839355,
        "Lng": 106.69524383544922,
        "Type": 0
      },
      {
        "Name": "[Q1 187] Khách sạn New World",
        "Lat": 10.770964,
        "Lng": 106.695946,
        "Type": 1
      }
    ],
    "coordRoute": {
      "03_[Q1 187] Khách sạn New World_[BX 01] Bến xe buýt Sài Gòn": [
        {
          "Latitude": 10.770964,
          "Longitude": 106.695946
        },
        {
          "Latitude": 10.77096367,
          "Longitude": 106.69594574
        }
      ]
    },
    "Title": "Đi tuyến: 03",
    "Desc": "Số tuyến cần đi: 1\nĐi bộ: 0.2 km; Xe buýt: 0.9 km"
  }
]
```

## 3. STIS Map Tile Service

**URL:** `http://map.stis.vn/bright/:index_1/:index_2/:map_tile`

### Parameters
| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `index_1` | Integer | First tile index (scheme unknown) | 16 |
| `index_2` | Integer | Second tile index (scheme unknown) | 52189 |
| `map_tile` | String | Tile filename | 30797.png |

### Response Format
Returns a PNG image tile. The indexing scheme is not fully understood.

## 4. Traffic Information Walking Route API

**URL:** `http://api.thongtingiaothong.vn/v2/route/foot/106.68900299072266,10.768851280212402;106.689362,10.767676`

### Parameters
| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| coordinates | String | Start and end coordinates separated by semicolon | 106.68900299072266,10.768851280212402;106.689362,10.767676 |
| steps | Boolean | Whether to include detailed steps | false |
| geometries | String | Route geometry format | polyline |
| overview | String | Level of route detail | full |

### Response Format
Intended to provide walking routes based on current traffic situation. **Currently returns 404 errors** - endpoint may be non-functional.
