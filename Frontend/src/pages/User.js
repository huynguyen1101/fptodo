
import React, { useState } from "react";
import { Link } from "react-router-dom";
import { v4 as uuidv4 } from "uuid";
import avatar from "../static/img/avatar.png";
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

import a from "../static/img/404.jpg";
// import 'bootstrap/dist/css/bootstrap.css';


const User = (props) => {




  useDocumentTitle("Boards | FPTODO");
  const [showAddBoardModal, setShowAddBoardModal] = useState(false);
  const [boardProject, setBoardProject] = useState(0); // If 0, we are making a personal board. Else, making board for project with given ID
  const [showTeamModal, setShowTeamModal] = useState(false);
  const { data: projects, addItem: addProject } = useAxiosGet("/projects/");
  console.log(projects);
  const {
    data: boards,
    addItem: addBoard,
    replaceItem: replaceBoard,
  } = useAxiosGet("/boards/"); // replaceBoard when you star or unstar
  const { data: recentlyViewedBoards } = useAxiosGet("/boards/?sort=recent");
  const [userBoards, projectBoards, starredBoards] = filterBoards(boards);
  const resultFilter = filterBoards(boards);

  console.log([userBoards, projectBoards, starredBoards])
  if (!boards) return null;
  const boardExist = [];
  const checkExistBoard = projects.map((itemBoard) => {
    const result = projectBoards.find((board) => {
      if (board.id === itemBoard.id) {
        return true
      }
    });
    console.log(result)
    if (result) {
      return
    } else {
      boardExist.push(itemBoard)
    }

  })
  console.log(boardExist)
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
              {/* <div className="author">

                <img src={a} className="center"></img>
                <h2 style={{ color: "blue", paddingTop: "100px", fontFamily: "cursive", fontSize: "2em" }}>
                  UserName
                </h2>
                <h4 style={{ paddingTop: "10px", opacity: "0.5" }}>@User</h4>
              </div>
              <div className="author-description">
                <p style={{ paddingTop: "20px", opacity: "0.5" }}>
                  "Cuộc sống mà  <br />
                  Never giver up <br />Never giver up"
                </p>
                <p style={{ paddingTop: "20px", opacity: "0.5" }}>-------------------------</p>
              </div> */}

              <div className="card-user">
                <div className="image">
                  <img className="bg4-user" src={bg4} />
                </div>
                <div className="card-body">
                  <div className="author">
                    <a href="#">
                      <img className="avatar-user" src={lisa} />
                      <h5 className="title">Chet Faker</h5>
                    </a>
                    <p className="description">@chetfaker</p>
                  </div>
                  <p className="description text-center">
                    ""I like the way you work it "
                    <br></br>
                    "No diggity"
                    <br></br>
                    "I wanna bag it up""
                  </p>
                </div>
              </div>
              {/* <div className="card-project">
                <div className="card-project-header">
                  <h5 className="card-title">List Project</h5>
                </div>
                <div className="card-list">
                  <ul>
                    <li>
                      {projects.map((project) => (
                        <Link
                          to={`/p/${project.id}`}
                          className="btn btn--transparent btn--small"
                          key={uuidv4()}
                        >
                          <span><i className="fal fa-users"></i> {project.title}</span>
                        </Link>
                      ))}
                    </li>
                  </ul>
                </div>
              </div> */}

            </div>








            <div className="card-info">
              <div className="card-title">Edit Profile</div>
              <div className="card-body">
                <form>
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
                        <label>Username</label>
                        <input placeholder="Username" type="text" className="form-control" value="trungkien123" />
                      </div>
                    </div>
                    <div className="col-lg-8 col-12">
                      <div className="form-group">
                        <label>Email address</label>
                        <input placeholder="Email " type="email" className="form-control" />
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="col-lg-6 col-12">
                      <div className="form-group">
                        <label>First Name</label>
                        <input placeholder="Firstname" type="text" className="form-control" value="Kien" />
                      </div>
                    </div>
                    <div className="col-lg-6 col-12">
                      <div className="form-group">
                        <label>Last Name</label>
                        <input placeholder="Lastname" type="text" className="form-control" value="Le" />
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="col-12">
                      <div className="form-group">
                        <label>Address</label>
                        <input placeholder="Address" type="text" className="form-control" value="001,DaNang, VietNam" />
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="col-lg-6 col-12">
                      <div className="form-group">
                        <label>City</label>
                        <input placeholder="City" type="text" className="form-control" value="DaNang" />
                      </div>
                    </div>
                    <div className="col-lg-6 col-12">
                      <div className="form-group">
                        <label>Country</label>
                        <input placeholder="Country" type="text" className="form-control" value="VietNam" />
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="about">
                      <div className="form-group">
                        <label>About me</label>
                        <textarea className="form-control">oh no</textarea>
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="col-6 btn-wrapper">
                      <button type="submit" className="btn-update">Update profile</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      {showTeamModal && (
        <CreateTeamModal
          setShowModal={setShowTeamModal}
          addProject={addProject}
        />
      )}
      {showAddBoardModal && (
        <AddBoardModal
          setShowAddBoardModal={setShowAddBoardModal}
          addBoard={addBoard}
          project={boardProject}
        />
      )}

    </>
  );
}

export default User;