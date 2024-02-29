class CommonApi {
  final int? id;
  final String? name;
  final String? address;
  final String? type;
  final int? state;
  final String? phone;
  final String? note;
  final int? price;
  final DateTime? date;
  const CommonApi(
      {this.id,
      this.name,
      this.address,
      this.type,
      this.state,
      this.note,
      this.phone,
      this.price,
      this.date});
}

class User extends CommonApi{
  final String? password;
  const User({super.id,super.name,super.type,super.state,super.phone,this.password});
  factory User.fromjson(Map<String,dynamic> json){
    return User(
      id: json["user_id"] != null ? json["user_id"] as int : 0,
      name: json["user_name"] != null ? json["user_name"] as String : '',
      type: json["user_type"] != null ? json["user_type"] as String : '',
      state: json["user_state"] != null ? json["user_state"] as int : 0,
      password: json["user_password"] != null ? json["user_password"] as String : '',
      phone: json["user_phone"] != null ? json["user_phone"] as String : '',
    );
  }
}
class Service extends CommonApi{
  final String? url;
  const Service({super.id,super.name,super.note,this.url});
  factory Service.fromjson(Map<String,dynamic> json){
    return Service(
      id: json["service_id"] != null ? json["service_id"] as int : 0,
      name: json["service_name"] != null ? json["service_name"] as String : '',
      note: json["service_note"] != null ? json["service_note"] as String : '',
      url: json["service_photo"] != null ? json["service_photo"] as String : '',

    );
  }
}
class Photo extends CommonApi{
  final int? serviceID;
  final String? name2;
  const Photo({super.id,super.name,this.serviceID,this.name2});
  factory Photo.fromjson(Map<String,dynamic> json){
    return Photo(
      id: json["photo_id"] != null ? json["photo_id"] as int : 0,
      serviceID: json["product_id"] != null ? json["product_id"] as int : 0,
      name: json["photo_url"] != null ? json["photo_url"] as String : '',
    );
  }
}
// class Photo2 extends CommonApi{
//   final int? serviceID;
//   final String? name2;
//   const Photo2({super.id,super.name,this.serviceID,this.name2});
//   factory Photo2.fromjson(Map<String,dynamic> json){
//     return Photo2(
//       id: json["service_id"] != null ? json["service_id"] as int : 0,
//       serviceID: json["product_id"] != null ? json["product_id"] as int : 0,
//       name: json["photo_url"] != null ? json["photo_url"] as String : '',
//       name2: json["service_name"] != null ? json["service_name"] as String : '',
//     );
//   }
// }
class Period extends CommonApi{
  const Period({super.id,super.name,super.note});
  factory Period.fromjson(Map<String,dynamic> json){
    return Period(
      id: json["timeperiod_id"] != null ? json["timeperiod_id"] as int : 0,
      name: json["timeperiod_name"] != null ? json["timeperiod_name"] as String : '',
      note: json["timeperiod_note"] != null ? json["timeperiod_note"] as String : '',
    );
  }
}
class Price extends CommonApi{
  final int? serviceID,periodID;
  const Price({super.id,super.price,this.serviceID,this.periodID});
  factory Price.fromjson(Map<String,dynamic> json){
    return Price(
      id: json["pricing_id"] != null ? json["pricing_id"] as int : 0,
      price: json["pricing_price"] != null ? json["pricing_price"] as int : 0,
      periodID: json["timeperiod_id"] != null ? json["timeperiod_id"] as int : 0,
      serviceID: json["product_id"] != null ? json["product_id"] as int : 0,
    );
  }
}
class GivserService extends CommonApi{
  final int? userID,serviceID;
  
  const GivserService({super.id,super.name,super.note,super.address,this.userID,this.serviceID});
  factory GivserService.fromjson(Map<String,dynamic> json){
    return GivserService(
      id: json["givser_id"] != null ? json["givser_id"] as int : 0,
      userID: json["user_id"] != null ? json["user_id"] as int : 0,
      serviceID: json["service_id"] != null ? json["service_id"] as int : 0,
      name: json["givser_name"] != null ? json["givser_name"] as String : '',
      address: json["givser_address"] != null ? json["givser_address"] as String : '',

    );
  }
}
class Services extends CommonApi{
  // final String? image;
  final int? givserID;
  // final List<String>? images;
  const Services({super.id,super.name,super.note,this.givserID});
  factory Services.fromjson(Map<String,dynamic> json){
    return Services(
      id: json["product_id"] != null ? json["product_id"] as int : 0,
      givserID: json["giver_id"] != null ? json["giver_id"] as int : 0,
      name: json["product_name"] != null ? json["product_name"] as String : '',
      note: json["product_description"] != null ? json["product_description"] as String : '',
      // image: json["image"] != null ? json["image"] as String : '',
      // images: json["images"] != null ? json["image"] as List : [],
    );
  }
}
class Reserve extends CommonApi{
  final String? customerName,period,paymentMethod;
  final int? quentity,productID,timeperiodID ;
  final DateTime? reserveDate;
  const Reserve({super.id,super.name,super.state,super.price,super.phone,super.date,this.productID,this.timeperiodID,this.customerName,this.quentity,this.period,this.reserveDate,this.paymentMethod});
  factory Reserve.fromjson(Map<String,dynamic> json){
    return Reserve(
      id: json["reserve_id"] != null ? json["reserve_id"] as int : 0,
      productID: json["product_id"] != null ? json["product_id"] as int : 0,
      timeperiodID: json["timeperiod_id"] != null ? json["timeperiod_id"] as int : 0,
      quentity: json["reserve_quantity"] != null ? json["reserve_quantity"] as int : 0,
      name: json["coustomer_name"] != null ? json["coustomer_name"] as String : '',
      paymentMethod: json["payment_method"] != null ? json["payment_method"] as String : '',
      phone: json["coustomer_phone"] != null ? json["coustomer_phone"] as String : '',
      customerName: json["reserve_purpose"] != null ? json["reserve_purpose"] as String : '',
      period: json["period"] != null ? json["period"] as String : '',
      state: json["reserve_status"] != null ? json["reserve_status"] as int : 0,
      price: json["reserve_price"] != null ? json["reserve_price"] as int : 0,
      date: json["reserve_day"] != null
            ? DateTime.tryParse(json["reserve_day"])
            : DateTime.now(),
      reserveDate: json["reserve_date"] != null
            ? DateTime.tryParse(json["reserve_date"])
            : DateTime.now(),
            
            );
  }
}