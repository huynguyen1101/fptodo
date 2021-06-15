import React from 'react';
const RegisterForm = () =>{
    
    return (
        <div class="limiter">
			<img src="logo.png" style={{width: 200, height:50, marginLeft:560}}/>
		<div class="container-login100">
			
			<div class="wrap-login100">
				<form class="login100-form validate-form p-l-55 p-r-55 p-t-178">
					<span class="login100-form-title">
						REGISTER
					</span>

					<div class="wrap-input100 validate-input m-b-16" data-validate="Please enter username">
						{/* <img src = "logouser.png" style={{width:30, marginTop : 50, marginLeft:5}}/> */}
						<input  class="input100" type="text" name="username" placeholder="Username"/>
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Please enter password">
						{/* <img src = "password.png" style={{width:30, marginTop : 50, marginLeft:5, borderRadius: 10}}/> */}
						<input class="input100" type="password" name="pass" placeholder="Password" />
						<span class="focus-input100"></span>
					</div>
					

					<div class="wrap-input100 validate-input" data-validate = "Please enter match password" style={{marginTop:15}}>
						{/* <img src = "re-password.png" style={{width:30, marginTop : 50, marginLeft:5}}/>	 */}
						<input class="input100" type="password" name="pass" placeholder="Re-Password"/>
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate = "Please enter valid email" style={{marginTop:15}}>
					{/* <img src = "email.png" style={{width:30, marginTop : 50, marginLeft:5}}/> */}
						<input class="input100" type="email" name="pass" placeholder="Email"/>
						<span class="focus-input100"></span>
					</div>

					<div class="text-right p-t-13 p-b-23">
						{/* <span class="txt1">
							Forgot
						</span>

						<a href="#" class="txt2">
							Username / Password?
						</a> */}
					</div>

					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Sign in
						</button>
					</div>

					<div class="flex-col-c p-t-30 p-b-20" >
						<span class="txt1 p-b-9">
							Have an account?
						</span>

						<a href="#" class="txt3">
							Sign up now
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
    );
};

export default RegisterForm