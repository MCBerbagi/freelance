/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import { ModalDirective } from 'ngx-bootstrap/modal';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-freelancer',
  templateUrl: './freelancer.component.html',
  styleUrls: ['./freelancer.component.scss']
})
export class FreelancerComponent implements OnInit {
  @ViewChild('myModal2') public myModal2: ModalDirective;
  firstName: any = '';
  lastName: any = '';
  email: any = '';
  password: any = '';
  country_code: any = '';
  mobile: any = '';
  gender: any = '1';
  cover: any = '';
  categories: any[] = [];
  rate: any = '';
  selectedItems = [];
  cities: any[] = [];
  hourly: any = '';
  lat: any = '';
  lng: any = '';
  descriptions: any = '';
  cityID: any = '';
  zipcode: any = '';
  experience: any = '';
  dropdownSettings = {
    singleSelection: false,
    idField: 'id',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    allowSearchFilter: true
  };
  freelancers: any[] = [];
  dummyFreelacer: any[] = [];

  freelancerId: any = '';
  freelancerUId: any = '';
  action: any = 'create';
  page: number = 1;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getFreelancer();
    this.getAllCates();
    this.getAllCities();
  }

  ngOnInit(): void {
  }

  getFreelancer() {
    this.dummyFreelacer = Array(5);
    this.freelancers = [];
    this.api.get_private('v1/freelancer/getAll').then((data: any) => {
      this.dummyFreelacer = [];
      console.log(data);
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.freelancers = data.data;
        }
      }
    }, error => {
      this.dummyFreelacer = [];
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummyFreelacer = [];
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  exportCSV() {

  }

  importCSV() {

  }

  createNew() {
    this.action = 'create';
    this.clearData();
    this.myModal2.show();
  }

  preview_banner(files: any) {
    console.log('fle', files);
    if (files.length == 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }

    if (files) {
      console.log('ok');
      this.util.show();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>>>>>', data.data);
        this.util.hide();
        if (data && data.data.image_name) {
          this.cover = data.data.image_name;
        }
      }, err => {
        console.log(err);
        this.util.hide();
      });
    } else {
      console.log('no');
    }
  }

  getAllCates() {
    ///getAll
    this.api.get_private('v1/category/getAll').then((data: any) => {
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.categories = data.data;
          console.log("====", this.categories);
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getAllCities() {
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  createFreelancer() {
    console.log(this.firstName);
    console.log(this.lastName);
    console.log(this.email);
    console.log(this.password);
    console.log(this.country_code);
    console.log(this.mobile);
    console.log(this.selectedItems);
    console.log(this.experience);
    console.log(this.cityID);
    console.log(this.zipcode);
    console.log(this.lat);
    console.log(this.lng);
    console.log(this.descriptions);
    console.log(this.cover);
    if (this.firstName == '' || this.lastName == '' || this.email == ''
      || this.password == '' || this.country_code == '' || this.mobile == ''
      || this.selectedItems.length <= 0 || this.hourly == '' || this.experience == '' || this.cityID == ''
      || this.zipcode == '' || this.lat == '' || this.lng == '' || this.descriptions == ''
      || this.mobile == null || this.hourly == null || this.experience == null || this.cover == '' || this.rate == '' || this.rate == null) {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }

    const regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (!regex.test(this.email)) {
      this.util.error(this.util.translate('Please enter valid Email ID'));
      return false;
    }
    console.log(typeof this.country_code)
    const cc: string = (this.country_code).toString();
    if (!cc.includes('+')) {
      this.country_code = '+' + this.country_code
    };

    const param = {
      first_name: this.firstName,
      last_name: this.lastName,
      gender: this.gender,
      cover: this.cover,
      mobile: this.mobile,
      email: this.email,
      country_code: this.country_code,
      password: this.password
    };
    this.util.show();
    this.api.post_private('v1/auth/createFreelancerAccount', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data.status == 500) {
        this.util.error(data.message);
      }
      if (data && data.status && data.status == 200 && data.user && data.user.id) {
        console.log(data);
        this.saveFreelancerAccount(data.user.id);
      } else if (data && data.error && data.error.msg) {
        this.util.error(data.error.msg);
      } else if (data && data.error && data.error.message == 'Validation Error.') {
        for (let key in data.error[0]) {
          console.log(data.error[0][key][0]);
          this.util.error(data.error[0][key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }, error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }).catch(error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    });

  }

  saveFreelancerAccount(uid: any) {
    console.log('uid', uid);
    const ids = this.selectedItems.map((x: any) => x.id);
    console.log(ids);
    const body = {
      uid: uid,
      name: this.firstName + ' ' + this.lastName,
      status: 1,
      lat: this.lat,
      lng: this.lng,
      cover: this.cover,
      served_category: ids.join(),
      hourly_price: this.hourly,
      gallery: 'NA',
      descriptions: this.descriptions,
      total_experience: this.experience,
      cid: this.cityID,
      zipcode: this.zipcode,
      rating: 0,
      total_rating: 0,
      verified: 1,
      available: 1,
      have_shop: 0,
      popular: 0,
      in_home: 1,
      extra_field: 'NA',
      rate: this.rate
    };
    this.util.show();
    this.api.post_private('v1/freelancer/create', body).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.success) {
        this.myModal2.hide();
        this.getFreelancer();
        this.clearData();
        this.util.success(this.util.translate('Freelancer added !'));
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  clearData() {
    this.firstName = '';
    this.lastName = '';
    this.email = '';
    this.password = '';
    this.country_code = '';
    this.mobile = '';
    this.selectedItems = [];
    this.experience = '';
    this.cityID = ''
    this.zipcode = '';
    this.lat = '';
    this.lng = '';
    this.descriptions = '';
    this.cover = '';
    this.hourly = '';
  }

  statusUpdate(item: any) {
    console.log(item);
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To update this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        const body = {
          id: item.id,
          status: item.status == 0 ? 1 : 0
        };
        console.log("======", body);
        this.util.show();
        this.api.post_private('v1/freelancer/update', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status == 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
            this.getFreelancer();
          }
        }, error => {
          this.util.hide();
          console.log('Error', error);
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log('Err', error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  deleteItem(item: any) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To delete this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        console.log(item);
        console.log(item);
        this.util.show();
        this.api.post_private('v1/freelancer/destroy', { id: item.id, uid: item.uid }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status == 200) {
            this.getFreelancer();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  changeShop(item: any) {
    console.log(item);
    const body = {
      id: item.id,
      have_shop: item.have_shop == 0 ? 1 : 0
    };
    console.log("======", body);
    this.util.show();
    this.api.post_private('v1/freelancer/update', body).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status == 200 && data.success) {
        this.util.success(this.util.translate('Status Updated !'));
        this.getFreelancer();
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  changeHome(item: any) {
    console.log(item);
    const body = {
      id: item.id,
      in_home: item.in_home == 0 ? 1 : 0
    };
    console.log("======", body);
    this.util.show();
    this.api.post_private('v1/freelancer/update', body).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status == 200 && data.success) {
        this.util.success(this.util.translate('Status Updated !'));
        this.getFreelancer();
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  changePopular(item: any) {
    console.log(item);
    const body = {
      id: item.id,
      popular: item.popular == 0 ? 1 : 0
    };
    console.log("======", body);
    this.util.show();
    this.api.post_private('v1/freelancer/update', body).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status == 200 && data.success) {
        this.util.success(this.util.translate('Status Updated !'));
        this.getFreelancer();
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  updateInfo(id: any, uid: any) {
    console.log(id);
    this.freelancerId = id;
    this.freelancerUId = uid;
    this.util.show();
    this.api.post_private('v1/freelancer/getById', { id: uid }).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.action = 'update';
        this.selectedItems = data.data.web_cates_data;
        this.firstName = data.data.user_info.first_name;
        this.lastName = data.data.user_info.last_name;
        this.hourly = data.data.hourly_price;
        this.experience = data.data.total_experience;
        this.cityID = data.data.cid;
        this.zipcode = data.data.zipcode;
        this.lat = data.data.lat;
        this.lng = data.data.lng;
        this.descriptions = data.data.descriptions;
        this.cover = data.data.user_info.cover;
        this.action = 'edit';
        if (data && data.data && data.data.rate) {
          this.rate = data.data.rate.rate;
        }
        this.myModal2.show();
      }
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

  updateFreelancer() {
    console.log('update item');
    const ids = this.selectedItems.map((x: any) => x.id);
    console.log(ids);
    const param = {
      id: this.freelancerId,
      first_name: this.firstName,
      last_name: this.lastName,
      cover: this.cover,
      served_category: ids.join(),
      hourly_price: this.hourly,
      descriptions: this.descriptions,
      total_experience: this.experience,
      cid: this.cityID,
      zipcode: this.zipcode,
      uid: this.freelancerUId,
      lat: this.lat,
      lng: this.lng,
      rate: this.rate
    }
    console.log(param);

    this.util.show();
    this.api.post_private('v1/freelancer/updateInfo', param).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status == 200 && data.success) {
        this.myModal2.hide();
        this.util.success(this.util.translate('Updated'));
        this.getFreelancer();
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }
}
