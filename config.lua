Config = Config or {}

-- Geschwindigkeit in km/h
Config.SpeedCameras = {
    {
        coords = vector3(1625.0442, 1079.1605, 80.7755),
        speedLimit = 120,
        fineAmount = 750,
        showBlip = true,
        blipLabel = "Blitzer (120 km/h)"
    },
    {
        coords = vector3(2499.0962, 114.3999, 99.6499),
        speedLimit = 120,
        fineAmount = 750,
        showBlip = true,
        blipLabel = "Blitzer (120 km/h)"
    },
    {
        coords = vector3(227.2472, -669.3995, 37.3155),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
    {
        coords = vector3(776.1918, -2140.5457, 28.6982),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
    {
        coords = vector3(-220.9403, -980.2547, 29.0328),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
    {
        coords = vector3(-1177.4709, -844.2076, 13.8426),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
    {
        coords = vector3(101.3869, -176.3846, 54.5624),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
    {
        coords = vector3(-66.3748, -732.4359, 33.4483),
        speedLimit = 80,
        fineAmount = 500,
        showBlip = true,
        blipLabel = "Blitzer (80 km/h)"
    },
}

Config.Radius = 20.0

-- Jobs, die nicht geblitzt werden
Config.ExemptedJobs = {
    'police',
    'ambulance',
    'fire',
    'admin',
}
