-- Hotel Management System Schema

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS hotels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  location TEXT NOT NULL,
  description TEXT,
  rating REAL,
  image_url TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rooms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  hotel_id INTEGER NOT NULL,
  room_number TEXT NOT NULL,
  room_type TEXT NOT NULL,
  capacity INTEGER NOT NULL,
  price_per_night REAL NOT NULL,
  description TEXT,
  amenities TEXT,
  is_available BOOLEAN DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE IF NOT EXISTS reservations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  room_id INTEGER NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  total_price REAL NOT NULL,
  status TEXT DEFAULT 'confirmed',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE IF NOT EXISTS payments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  reservation_id INTEGER NOT NULL,
  amount REAL NOT NULL,
  payment_method TEXT NOT NULL,
  status TEXT DEFAULT 'completed',
  transaction_id TEXT UNIQUE,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);

CREATE TABLE IF NOT EXISTS reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  reservation_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  hotel_id INTEGER NOT NULL,
  rating INTEGER NOT NULL,
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (reservation_id) REFERENCES reservations(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE IF NOT EXISTS loyalty_programs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  points INTEGER DEFAULT 0,
  tier TEXT DEFAULT 'bronze',
  total_spent REAL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS loyalty_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  points_earned INTEGER DEFAULT 0,
  points_redeemed INTEGER DEFAULT 0,
  transaction_type TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS rewards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  points_required INTEGER NOT NULL,
  category TEXT NOT NULL,
  image_url TEXT,
  is_active BOOLEAN DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS reward_redemptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  reward_id INTEGER NOT NULL,
  redemption_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status TEXT DEFAULT 'redeemed',
  qr_code TEXT UNIQUE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (reward_id) REFERENCES rewards(id)
);

CREATE TABLE IF NOT EXISTS amenities (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  icon TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS room_amenities (
  room_id INTEGER NOT NULL,
  amenity_id INTEGER NOT NULL,
  PRIMARY KEY (room_id, amenity_id),
  FOREIGN KEY (room_id) REFERENCES rooms(id),
  FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

CREATE TABLE IF NOT EXISTS favorites (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  hotel_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, hotel_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE IF NOT EXISTS notifications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  type TEXT NOT NULL,
  is_read BOOLEAN DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS hotel_images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  hotel_id INTEGER NOT NULL,
  image_url TEXT NOT NULL,
  alt_text TEXT,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE IF NOT EXISTS booking_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  reservation_id INTEGER NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  hotel_name TEXT NOT NULL,
  nights INTEGER NOT NULL,
  total_price REAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_rooms_hotel_id ON rooms(hotel_id);
CREATE INDEX IF NOT EXISTS idx_reservations_user_id ON reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_reservations_room_id ON reservations(room_id);
CREATE INDEX IF NOT EXISTS idx_payments_reservation_id ON payments(reservation_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user_id ON reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_reviews_hotel_id ON reviews(hotel_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_user_id ON loyalty_programs(user_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_transactions_user_id ON loyalty_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_reward_redemptions_user_id ON reward_redemptions(user_id);
CREATE INDEX IF NOT EXISTS idx_favorites_user_id ON favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_history_user_id ON booking_history(user_id);
