import 'package:room_sharing/Models/Conversation_model.dart';
import 'package:room_sharing/Models/message_model.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Models/user_model.dart';

import 'booking_model.dart';
import 'review_model.dart';

class DummyData {
  // User Data

  static List<User> users = [];
  static List<Posting> postings = [];

  static populateFields() {
    User user1 = User(
        firstName: 'Sumith',
        lastName: 'Damodaran',
        imagePath: 'assets/images/sumith2020.jpg',
        email: 'spd@gmail.com',
        bio: 'I build products',
        city: 'london',
        country: 'United Kingdom');
    user1.isHost = true;
    User user2 = User(
        firstName: 'Sammy',
        lastName: 'Boy',
        imagePath: 'assets/images/defaultAvatar.jpg',
        email: 'sammyboy@gmail.com',
        bio: 'Sammy is cool',
        city: 'New York',
        country: 'United States');

    users.add(user1);
    users.add(user2);

    Review review = Review(
        contact: user2.createContactFromUser(),
        text: "Amazing host, BFF for life",
        rating: 4.5,
        dateTime: DateTime.now());

    user1.reviews.add(review);

    //Adding conversation with some messages to user1
    Conversation conversation = Conversation();
    conversation.createConversation(user2.createContactFromUser(), []);

    Message message1 = Message();
    message1.createMessage(
      user1.createContactFromUser(),
      "Hey, how is it going?",
      DateTime.now(),
    );

    Message message2 = Message();
    message2.createMessage(
      user2.createContactFromUser(),
      "Its Amazing, I am super happy to hear from you.",
      DateTime.now(),
    );
    conversation.messages.add(message1);
    conversation.messages.add(message2);
    user1.conversations.add(conversation);

    //Posting
    Posting posting1 = Posting(
        name: 'Cool Casa',
        type: 'House',
        price: 120,
        description: "Groovy house in the heart of the suburbs, perfect",
        address: '123 tower of london',
        city: 'London',
        country: 'United Kingdom',
        host: user1.createContactFromUser());
    posting1.setImages([
      'assets/images/apartment.jpg',
      'assets/images/interior1.jpg',
    ]);
    posting1.amenities = ['washers', 'dryer', 'iron', 'coffee machine'];
    posting1.beds = {
      'small': 0,
      'medium': 2,
      'large': 2,
    };
    posting1.baths = {'full': 2, 'half': 1};

    Posting posting2 = Posting(
        name: 'Awesome Apartment',
        type: 'Apartment',
        price: 100,
        description: "Modern and cic, central location, convenient",
        address: '123 Central London',
        city: 'London',
        country: 'United Kingdom',
        host: user2.createContactFromUser());
    posting2.setImages([
      'assets/images/interior0.jpg',
      'assets/images/interior1.jpg',
    ]);
    posting2.amenities = ['dishwasher', 'Cable', 'Wifi'];
    posting2.beds = {
      'small': 1,
      'medium': 0,
      'large': 1,
    };
    posting2.baths = {'full': 1, 'half': 1};

    Review postingReview1 = Review(
      contact: user2.createContactFromUser(),
      text: 'Great view , Impressive decor',
      rating: 4.5,
      dateTime: DateTime(2021, 11, 11),
    );
    posting1.reviews.add(postingReview1);
    Review postingReview2 = Review(
      contact: user2.createContactFromUser(),
      text: 'Decent place, not as big as I was expecting',
      rating: 3.5,
      dateTime: DateTime(2021, 11, 11),
    );
    posting2.reviews.add(postingReview2);

    postings.add(posting1);
    postings.add(posting2);

    Booking booking1 = Booking(
        posting: posting2,
        contact: user1.createContactFromUser(),
        dates: [
          DateTime(2021, 11, 11),
          DateTime(2021, 11, 12),
          DateTime(2021, 11, 15)
        ]);

    Booking booking2 = Booking(
        posting: posting2,
        contact: user1.createContactFromUser(),
        dates: [
          DateTime(2021, 11, 21),
          DateTime(2021, 11, 22),
          DateTime(2021, 11, 23)
        ]);

    posting2.bookings.add(booking1);

    user1.bookings.add(booking1);
    user1.bookings.add(booking2);
    user1.savedPosting.add(posting2);
  }
}
