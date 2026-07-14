import random
import pandas as pd


def generate_weather_ilp_dataset(
        n_samples=10000,
        seed=42):

    random.seed(seed)

    data = []


    # -----------------------------
    # Hidden background predicates
    # -----------------------------

    def humidity_index(T, H):
        return H*T/100


    def cloud_density(C, H):
        return C*H/100


    def thermal_instability(dT, H):
        return abs(dT)*H


    def cloud_instability(CD, dP):
        return CD*abs(dP)


    def storm_potential(CI, TI):
        return CI*TI


    def rain_potential(HI, CD):
        return HI*CD


    def visibility_degradation(HI, CD):
        return HI+CD



    # -----------------------------
    # Generate observations
    # -----------------------------

    for idx in range(n_samples):


        # Base observations

        temperature = random.uniform(-10,35)

        humidity = random.uniform(20,100)

        pressure = random.uniform(960,1040)

        wind_speed = random.uniform(0,120)

        cloud_cover = random.uniform(0,100)

        visibility = random.uniform(0.5,30)

        pressure_change = random.uniform(-15,15)

        temperature_change = random.uniform(-10,10)



        # Background concepts

        HI = humidity_index(
            temperature,
            humidity
        )

        CD = cloud_density(
            cloud_cover,
            humidity
        )

        TI = thermal_instability(
            temperature_change,
            humidity
        )

        CI = cloud_instability(
            CD,
            pressure_change
        )

        SP = storm_potential(
            CI,
            TI
        )

        RP = rain_potential(
            HI,
            CD
        )

        VD = visibility_degradation(
            HI,
            CD
        )



        # -----------------------------
        # Hidden classification theory
        # -----------------------------

        # priority avoids multiple labels

        if SP > 20000:
            label = "stormy"

        elif VD > 120 and visibility < 3:
            label = "foggy"

        elif RP > 500 and cloud_cover > 40:
            label = "rainy"

        elif CD < 25 and HI < 25:
            label = "sunny"

        else:
            # normal conditions
            # choose dominant weather state
            if cloud_cover < 40:
                label = "sunny"
            elif humidity > 70:
                label = "rainy"
            else:
                label = "foggy"



        data.append({

            "weather_id": f"w{idx}",

            # Base features only

            "temperature": temperature,
            "humidity": humidity,
            "pressure": pressure,
            "wind_speed": wind_speed,
            "cloud_cover": cloud_cover,
            "visibility": visibility,
            "pressure_change": pressure_change,
            "temperature_change": temperature_change,

            "class": label
        })


    return pd.DataFrame(data)



df = generate_weather_ilp_dataset(
    n_samples=50000
)


print(df["class"].value_counts())


df.to_csv(
    "weather_numeric_ilp_unbalanced.csv",
    index=False
)