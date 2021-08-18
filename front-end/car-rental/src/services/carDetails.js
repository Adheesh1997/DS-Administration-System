import axios from "axios";

const CAR_REST_API_URL = ""

class carDetails
{


    getCarDetails()
    {
        axios.get(CAR_REST_API_URL)
    }
}

export default new carDetails()