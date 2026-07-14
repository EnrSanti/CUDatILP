import random
import pandas as pd


MU = 398600.4


def generate_satellite_dataset(n=1000, seed=42):

    random.seed(seed)

    data = []

    while len(data) < n:

        sat = f"sat_{len(data)}"

        # -----------------------------
        # Base features (observations)
        # -----------------------------

        altitude = random.uniform(100, 5000)              # km
        velocity = random.uniform(5, 15)                 # km/s
        eccentricity = random.uniform(0, 0.8)

        mass = random.uniform(100, 5000)                 # kg

        nearest_distance = random.uniform(1, 2000)       # km
        relative_velocity = random.uniform(0.1, 15)      # km/s

        debris_density = random.uniform(0, 0.01)


        # ==================================================
        # Background knowledge (NOT stored as input features)
        # ==================================================

        # orbital energy
        orbital_energy = (
            velocity**2 / 2
            - MU / altitude
        )


        # atmospheric interaction
        drag_factor = 1 / (altitude**2)


        # eccentricity instability
        eccentricity_risk = (
            eccentricity**2 /
            (1 - eccentricity + 1e-9)
        )


        # time to encounter
        collision_time = (
            nearest_distance /
            relative_velocity
        )


        # collision severity
        collision_index = (
            mass *
            relative_velocity**2 /
            (nearest_distance**2)
        )


        # ==================================================
        # Hidden target concepts
        # ==================================================

        # 1) Escape risk
        if orbital_energy >= 0:
            label = "escape_risk"


        # 2) Collision risk
        elif (
            collision_time < 5
            and collision_index > 50
        ):
            label = "collision_risk"


        # 3) Atmospheric decay
        elif (
            drag_factor > 1/(200**2)
        ):
            label = "decaying_orbit"


        # 4) Stable orbit
        elif (
            orbital_energy < 0
            and eccentricity < 0.2
            and collision_index < 5
        ):
            label = "stable_orbit"


        # reject ambiguous samples
        else:
            continue


        # Store ONLY base features + label
        data.append({

            "satellite": sat,

            # Base predicates
            "altitude": altitude,
            "velocity": velocity,
            "eccentricity": eccentricity,
            "mass": mass,
            "nearest_distance": nearest_distance,
            "relative_velocity": relative_velocity,
            "debris_density": debris_density,

            # Target concept
            "class": label
        })


    return pd.DataFrame(data)



df = generate_satellite_dataset(50000)

print(df.head())

print("\nClass distribution:")
print(df["class"].value_counts())


df.to_csv(
    "satellite_ilp_dataset.csv",
    index=False
)
