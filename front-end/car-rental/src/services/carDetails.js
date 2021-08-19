import axios from "axios";

const CAR_REST_API_URL = "localhost:8100/rv/getAll"

class carDetails
{
    //id=>{review}

    getCarDetails()
    {
        axios.get(CAR_REST_API_URL)
    }
}

export default new carDetails()