import React, { useEffect, useContext } from "react";
import { Link } from "react-router-dom";
import { v4 as uuidv4 } from "uuid";
import { useState } from "react";
import "../../static/css/components/_sidebar-menu.scss";
import globalContext from "../../context/globalContext";

// const fakeApi = () => new Promise(resolve => setTimeout(() => {
//     resolve({
//         id: 1,
//         userName: "Hallo"
//     })
// }, 200))

const HomeSidebar = ({ setShowTeamModal, projects, sidebarclass, dropdownclass }) => {
    const { authUser } = useContext(globalContext);

    const [show, setShow] = useState(false);
    // const [user, setUser] = useState({});
    const [showDrop, setShowDrop] = useState(false);

    // useEffect(() => {
    //     const asyncFunc = async () => {
    //         const result = await fakeApi()
    //         setUser(result)
    //     }
    //     asyncFunc()
    // }, [])
    const handleClick = () => {
        setShow(!show);
    }
    sidebarclass = "sidebar-menu";

    if (show) {
        sidebarclass = "sidebar-menu close";
    }

    const handleClickDrop = () => {
        setShowDrop(!showDrop);
    }
    dropdownclass = "";
    let subMenuStyle = {
        height: `0px`,
    }




    if (showDrop) {
        dropdownclass = "show";

        if (!show) {
            subMenuStyle = {
                height: 50 * projects.length + "px",
            }
        }
    }

    return (
        // <div className="home-menu">
        <div className={sidebarclass}>


            <ul className="nav-links">
                <li onClick={handleClick}>

                    <i className="far fa-arrow-alt-circle-left blank" ></i>

                </li>
                <li>

                    <a href="#">
                        <i className="fab fa-trello turn"></i>
                        <span className="link_name">Board</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i className="fal fa-tachometer-alt"></i>
                        <span className="link_name">Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i className="fal fa-ruler-triangle"></i>
                        <span className="link_name">Templates</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i className="fal fa-newspaper"></i>
                        <span className="link_name">Feed</span>
                    </a>
                </li>
                <li >
                    <a href={`/profile/${authUser?.id}`}>
                        <i className="fas fa-user"></i>
                        <span className="link_name">User</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i className="fas fa-cog"></i>
                        <span className="link_name">Setting</span>
                    </a>
                </li>
                <li className={dropdownclass}>
                    <div className="icon-link">
                        <a href="#">
                            <button onClick={() => setShowTeamModal(true)}>
                                <i className="fal fa-plus"></i>
                            </button>
                            <span className="link_name">Project</span>
                        </a>

                        <i className="fas fa-sort-down arrow" onClick={handleClickDrop}></i>
                    </div>

                    <ul className="sub-menu" style={subMenuStyle}>
                        {projects.map((project) => (
                            <li key={project.id}>
                                <Link
                                    to={`/p/${project.id}`}
                                >
                                    <span><i className="fal fa-users "></i>{project.title}</span>
                                </Link>
                            </li>
                        ))}
                    </ul>
                </li>
            </ul>
        </div >
    );
};

export default HomeSidebar;
