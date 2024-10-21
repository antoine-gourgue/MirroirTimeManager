import axios from "axios"

// Users routes

export function getWorkingTimeByeUserId(idUser) {
  axios.get(`http://localhost:400/api/working_times/users/:${idUser}`)
}

export function getUserById(idUser) {
  axios.get(`http://localhost:4000/api/users/:${idUser}`)
    .then(response => {
      console.log(response);
      
    })
}

export function modifyUser(idUser) {
  axios.put(`http://localhost:4000/api/users/:${idUser}`)
    .then(response => {
      console.log(response);
      
    })
}

export function getWorkingTimeByUserId(idUser) {
  axios.put(`http://localhost:4000/api/working_times/users/:${idUser}`)
  .then(response => {
    console.log(response);
    
  })
}

export function createClock(){
  axios.post(`http://localhost:4000/api/clocks`)
  .then(response => {
    console.log(response);
    
  })
}

// Manager routes

export function getTeamsByManagerID(idUser){
  axios.get(`http://localhost:4000/api/users/:${idUser}/teams`)
  .then(response => {
    console.log(response);
    
  })
}

export function getUsersByTeamId(idTeam){
  axios.get(`http://localhost:4000/api/teams/:${idTeam}/users`)
  .then(response => {
    console.log(response);
    
  })
}

export function addUserToTeam(idUser, idTeam){
  axios.post(`http://localhost:4000/api/user_teams`)
  .then(response => {
    console.log(response);
    
  })
}

export function deleteUserFromTeam(idUserTeam){
  axios.delete(`http://localhost:4000/api/user_teams/:${idUserTeam}`)
  .then(response => {
    console.log(response);
    
  })
}

// Top manager routes

export function getAllUsers() {
  axios.get('http://localhost:4000/api/users')
    .then(response => {
      console.log(response)
    })
}

export function createUser(){
  axios.post(`http://localhost:4000/api/users`)
  .then(response => {
    console.log(response);
    
  })
}

export function editUser(idUser){
  axios.put(`http://localhost:4000/api/users/:${idUser}`)
  .then(response => {
    console.log(response);
    
  })
}

export function deleteUser(idUser){
  axios.delete(`http://localhost:4000/api/users/:${idUser}`)
  .then(response => {
    console.log(response);
    
  })
}

export function createTeam(){
  axios.post(`http://localhost:4000/api/teams`)
  .then(response => {
    console.log(response);
    
  })
}

export function editTeam(idTeam){
  axios.put(`http://localhost:4000/api/teams/:${idTeam}`)
  .then(response => {
    console.log(response);
    
  })
}

export function deleteTeam(idTeam){
  axios.delete(`http://localhost:4000/api/teams/:${idTeam}`)
  .then(response => {
    console.log(response);
    
  })
}

export function getAllTeams() {
  axios.get('http://localhost:4000/api/teams')
    .then(response => {
      console.log(response)
    })
}