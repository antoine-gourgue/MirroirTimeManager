import axios from "axios";

const token = sessionStorage.token

// Login
export function login(params) {
    return axios.post(`http://localhost:4000/api/login`, {
            username: params.username,
            email: params.email,
            password: params.password
        },
        {
            headers: {
                'Content-Type': 'application/json',
            }
        }
    )
        .then(response => {
            console.log(response);
            console.log('OK');
            return response.data;
        })
        .catch(error => {
            console.error("Login error:", error.response ? error.response.data : error.message);
            throw error;
        });
}

// Users routes

export async function getWorkingTimeByeUserId(idUser) {
  try {
    const response = await axios.get(`http://localhost:4000/api/working_times/users/${idUser}`, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response.data.data
  } catch(error){
    console.log(error);
    
  }
}

export async function getUserById(idUser) {
  try {
    let response = axios.get(`http://localhost:4000/api/users/${idUser}`, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response

  } catch(error) {
    console.log("Error while getting user :" + error);
  }
}

export async function modifyUser(idUser, params) {
  try {
    let response = await axios.put(`http://localhost:4000/api/users/${idUser}`, {
      user: params
    }, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response.data;
  } catch (error) {
    console.error("Error modifying user: ", error);
  }


}

export function getWorkingTimeByUserId(idUser) {
  axios.put(`http://localhost:4000/api/working_times/users/${idUser}`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export async function createWorkingTime(params){
  try {
    console.log(params);
    
    let response = await axios.post(`http://localhost:4000/api/working_times`, {working_time: params}, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    
    return response
  } catch(error) {
    console.log(error);
    
  }
}

export async function createClock(idUser, params){
  try {
    console.log(params);
    
    let response = await axios.post(`http://localhost:4000/api/clocks`, {clock: params}, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    console.log(response);
    
    return response
  } catch(error) {
    console.log(error);
    
  }
}

// Manager routes

export function getTeamsByManagerID(idUser){
  axios.get(`http://localhost:4000/api/users/${idUser}/teams`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export function getUsersByTeamId(idTeam){
  axios.get(`http://localhost:4000/api/teams/${idTeam}/users`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export function addUserToTeam(idUser, idTeam){
  axios.post(`http://localhost:4000/api/user_teams`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export function deleteUserFromTeam(idUserTeam){
  axios.delete(`http://localhost:4000/api/user_teams/${idUserTeam}`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

// Top manager routes

export async function getAllUsers() {
  try {
    let response = await axios.get('http://localhost:4000/api/users', {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response
  } catch(error) {
    console.log(error);
    
  }
}

export function createUser(params){
  try {
    let response = axios.post(`http://localhost:4000/api/users`, {user: params}, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response
  } catch(error) {
    console.log(error);
    
  }

}

export function editUser(idUser){
  axios.put(`http://localhost:4000/api/users/${idUser}`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export function deleteUser(idUser){
  axios.delete(`http://localhost:4000/api/users/${idUser}`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export async function createTeam(params){
  try {
    let response = await axios.post(`http://localhost:4000/api/teams`, {team: params}, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response
  } catch(error) {
    console.log(error);
    
  }
}

export function editTeam(idTeam){
  axios.put(`http://localhost:4000/api/teams/${idTeam}`, {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    }
  })
  .then(response => {
    console.log(response);
    
  })
}

export async function deleteTeam(idTeam){
  try {
    let response = await axios.delete(`http://localhost:4000/api/teams/${idTeam}`, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    console.log(response);
    return response

    
  } catch(error) {
    console.log(error);
    
  }

}

export async function getAllTeams() {
  try {
    let response = await axios.get('http://localhost:4000/api/teams', {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return response
  } catch(error) {
    console.log(error);
    
  }
}