import React, { useState, useEffect, useMemo, useContext, } from "react";
import { Link } from "react-router-dom";
import { v4 as uuidv4 } from "uuid";
import bg4 from "../static/img/bg4.jpg";
import lisa from "../static/img/lisa.jpg"
import AddBoardModal from "../components/modals/AddBoardModal";
import HomeSidebar from "../components/sidebars/HomeSidebar";
import HomeBoard from "../components/boards/HomeBoard";
import CreateTeamModal from "../components/modals/CreateTeamModal";
import useAxiosGet from "../hooks/useAxiosGet";
import useDocumentTitle from "../hooks/useDocumentTitle";
import { filterBoards } from "../static/js/board";
import "../static/css/components/_user.scss";
import { backendUrl } from "../static/js/const";
import a from "../static/img/404.jpg";
import axios from "axios";
import { CountryDropdown, RegionDropdown, CountryRegionData } from 'react-country-region-selector';
import Popup from 'reactjs-popup';
import 'reactjs-popup/dist/index.css';

import ProfilePic from "../components/boards/ProfilePic";
import globalContext from "../context/globalContext";

const User = (props) => {
  const [user, setUser] = React.useState(props.user);
  const [showTeamModal, setShowTeamModal] = useState(false);
  const { data: projects, addItem: addProject } = useAxiosGet("/projects/");
  const [showPopUp, setShowPopUp] = useState(false);
  const [popUpTitle, setPopUpTitle] = useState("");
  const [popUpStatus, setPopUpStatus] = useState("");
  const [popUpMessage, setPopUpMessage] = useState("");

  const { authUser, board } = useContext(globalContext);

  const token = localStorage.getItem("accessToken");
  const config = {
    headers: { Authorization: `Bearer ${token}` }
  };

  const updateProfile = async () => {
    try {
      const url = backendUrl + `/update_profile/${props.user.id}/`;
      await axios.put(url, user, config);
      setShowPopUp(true)
      setPopUpTitle("Update Success")
      setPopUpStatus("Success")
      setPopUpMessage("Your profile has been updated!")
    } catch (e) {
      setShowPopUp(true)
      setPopUpTitle("Update Fail")
      setPopUpStatus("Fail")
      setPopUpMessage(e.response?.data?.mess ? e.response?.data?.mess : 'Cannot get response from server')
    }
  }

  const handleUserChange = (e) => {
    const value = e.target.value;
    let new_user = { ...user }
    new_user[e.target.name] = value
    setUser(new_user)
  }

  const handleUserCountryChange = (e) => {
    let new_user = { ...user }
    new_user['country'] = e
    setUser(new_user)
  }

  const handleUserCityChange = (e) => {
    let new_user = { ...user }
    new_user['city'] = e
    setUser(new_user)
  }


  useEffect(() => {
    setUser(props.user);
  }, [props.user])


  const PopupExample = () => (
    <Popup trigger={<button> Trigger</button>} position="right center">
      <div>Popup content here !!</div>
    </Popup>
  );


  return (

    <>
      <div className="home-wrapper">
        <HomeSidebar
          setShowTeamModal={setShowTeamModal}
          projects={projects || []}
        />
        <div className="home">
          <div className="card-wrapper">
            <div className="card-account">


              <div className="card-user">
                <div className="image">
                  <img className="bg4-user" src={bg4} />
                </div>
                <div className="card-body">
                  <div className="author">
                    <a href="#">
                      <ProfilePic className="avatar" user={authUser} large={true} />
                      {/* <img className="avatar-user" src={lisa} /> */}
                      <h5 className="title">{user.full_name}</h5>
                    </a>
                    <p className="username">{`@` + user.username}</p>
                  </div>
                  <p className="description text-center">
                    {'"' + user.about_me + '"'}
                  </p>
                </div>
              </div>

            </div>



            <div className="card-info">
              <div className="card-title">Edit Profile</div>
              <div className="card-body">
                <div className="row">
                  <div className="col-lg-6 col-12">
                    <div className="form-group">
                      <label>Company</label>
                      <input disabled placeholder="Company" type="text" className="form-control" value="FPT" />
                    </div>
                  </div>
                </div>
                <div className="row">
                  <div className="col-lg-4 col-12">
                    <div className="form-group">
                      <label>Fullname</label>
                      <input
                        placeholder="Fullname"
                        name="full_name"
                        type="text"
                        className="form-control"
                        value={user.full_name}
                        disabled
                      />
                    </div>
                  </div>
                  <div className="col-lg-8 col-12">
                    <div className="form-group">
                      <label>Email address</label>
                      <input
                        placeholder="Email"
                        name="email"
                        type="email"
                        className="form-control"
                        value={user.email}
                        onChange={handleUserChange}
                      />
                      {/* <input placeholder="Email" type="email" className="form-control" value={user.email} onChange={onChangeEmail} /> */}
                    </div>
                  </div>
                </div>
                <div className="row">
                  <div className="col-lg-6 col-12">
                    <div className="form-group">
                      <label>First Name</label>
                      <input
                        placeholder="Firstname"
                        name="first_name"
                        type="text"
                        className="form-control"
                        value={user.first_name}
                        onChange={handleUserChange}
                      />
                    </div>
                  </div>
                  <div className="col-lg-6 col-12">
                    <div className="form-group">
                      <label>Last Name</label>
                      <input
                        placeholder="Lastname"
                        name="last_name"
                        type="text"
                        className="form-control"
                        value={user.last_name}
                        onChange={handleUserChange}
                      />
                    </div>
                  </div>
                </div>
                <div className="row">
                  <div className="col-lg-6 col-12">
                    <div className="form-group">
                      <label>Country</label>
                      <CountryDropdown
                        className="country-select"
                        value={user.country}
                        onChange={handleUserCountryChange}
                      />
                    </div>
                  </div>
                  <div className="col-lg-6 col-12">
                    <div className="form-group">
                      <label>City</label>
                      {/* <input
                        placeholder="City"
                        name="city"
                        type="text"
                        className="form-control"
                        value={user.city}
                        onChange={handleUserChange}
                      /> */}
                      <RegionDropdown
                        className="city-select"
                        country={user.country}
                        value={user.city}
                        onChange={handleUserCityChange}
                      />
                    </div>
                  </div>
                </div>
                <div className="row">
                  <div className="about">
                    <div className="form-group">
                      <label>About me</label>
                      <textarea
                        className="form-control"
                        name="about_me"
                        value={user.about_me}
                        onChange={handleUserChange}
                      />
                    </div>
                  </div>
                </div>
                <div className="row">
                  <div className="col-6 btn-wrapper">
                    <button type="submit" className="btn-update" onClick={updateProfile}>Update profile</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div
          className={showPopUp ? "overlay" : "overlay hidden"}
          onClick={() => setShowPopUp(false)}
        >
          <Popup
            open={showPopUp}
          >
            <div className="popup-dialog">
              <div className={popUpStatus === "Success" ? "title success" : "title fail"}>
                {popUpTitle}
              </div>
              <div className="content">
                {popUpMessage}
              </div>
            </div>
          </Popup>
        </div>
      </div>

      {showTeamModal && (
        <CreateTeamModal
          setShowModal={setShowTeamModal}
          addProject={addProject}
        />
      )}


    </>
  );
}

export default User;