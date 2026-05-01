-- IMPORTANTE: Ejecutar esto siempre al conectar para activar las relaciones
PRAGMA foreign_keys = ON;

-- 1. locations
CREATE TABLE locations (
    id TEXT PRIMARY KEY,
    country TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL
);

-- 2. hotels
CREATE TABLE hotels (
    id TEXT PRIMARY KEY,
    location_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    stars INTEGER CHECK (stars BETWEEN 1 AND 5),
    phone TEXT,
    email TEXT,
    cover_image_url TEXT,
    is_active INTEGER DEFAULT 1, -- 1=True, 0=False
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);

-- 3. room_types
CREATE TABLE room_types (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    base_price REAL NOT NULL DEFAULT 0.0,
    capacity INTEGER NOT NULL CHECK (capacity > 0)
);

-- 4. rooms
CREATE TABLE rooms (
    id TEXT PRIMARY KEY,
    hotel_id TEXT NOT NULL,
    room_type_id TEXT NOT NULL,
    room_number TEXT NOT NULL,
    floor INTEGER,
    is_available INTEGER DEFAULT 1,
    image_url TEXT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE RESTRICT
);

-- 5. guests
CREATE TABLE guests (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    lastname TEXT NOT NULL,
    phone TEXT,
    document_type TEXT,
    document_number TEXT UNIQUE,
    avatar_url TEXT,
    nationality TEXT
);

-- 6. reservations
CREATE TABLE reservations (
    id TEXT PRIMARY KEY,
    guest_id TEXT NOT NULL,
    room_id TEXT NOT NULL,
    check_in TEXT NOT NULL, -- Formato YYYY-MM-DD
    check_out TEXT NOT NULL,
    total_price REAL NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    adults INTEGER NOT NULL DEFAULT 1,
    children INTEGER DEFAULT 0,
    special_requests TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT
);

-- 7. payments
CREATE TABLE payments (
    id TEXT PRIMARY KEY,
    reservation_id TEXT NOT NULL,
    amount REAL NOT NULL,
    method TEXT CHECK (method IN ('card', 'transfer', 'cash')),
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'refunded')),
    paid_at TEXT,
    transaction_id TEXT,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

-- 8. reviews
CREATE TABLE reviews (
    id TEXT PRIMARY KEY,
    reservation_id TEXT UNIQUE NOT NULL,
    guest_id TEXT NOT NULL,
    hotel_id TEXT NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

-- 9. amenities
CREATE TABLE amenities (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    icon TEXT,
    category TEXT CHECK (category IN ('hotel', 'room'))
);

-- 10. hotel_amenities
CREATE TABLE hotel_amenities (
    hotel_id TEXT NOT NULL,
    amenity_id TEXT NOT NULL,
    PRIMARY KEY (hotel_id, amenity_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(id) ON DELETE CASCADE
);

-- 11. room_amenities
CREATE TABLE room_amenities (
    room_id TEXT NOT NULL,
    amenity_id TEXT NOT NULL,
    PRIMARY KEY (room_id, amenity_id),
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(id) ON DELETE CASCADE
);

-- 12. services
CREATE TABLE services (
    id TEXT PRIMARY KEY,
    hotel_id TEXT NOT NULL,
    name TEXT NOT NULL,
    price REAL NOT NULL DEFAULT 0.0,
    description TEXT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE
);

-- 13. reservation_services
CREATE TABLE reservation_services (
    id TEXT PRIMARY KEY,
    reservation_id TEXT NOT NULL,
    service_id TEXT NOT NULL,
    quantity INTEGER DEFAULT 1,
    subtotal REAL NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id)
);


-- 16. rewards
CREATE TABLE rewards (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    stars_cost INTEGER NOT NULL,
    type TEXT CHECK (type IN ('discount', 'free_night', 'service', 'upgrade')),
    is_active INTEGER DEFAULT 1
);

-- 17. reward_redemptions
CREATE TABLE reward_redemptions (
    id TEXT PRIMARY KEY,
    guest_id TEXT NOT NULL,
    reward_id TEXT NOT NULL,
    reservation_id TEXT,
    stars_spent INTEGER NOT NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'applied', 'expired')),
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (reward_id) REFERENCES rewards(id),
    FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);

-- 18. loyalty_transactions
CREATE TABLE loyalty_transactions (
    id TEXT PRIMARY KEY,
    guest_id TEXT NOT NULL,
    reservation_id TEXT,
    redemption_id TEXT,
    type TEXT NOT NULL CHECK (type IN ('earned', 'redeemed', 'bonus', 'expired')),
    stars INTEGER NOT NULL,
    description TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (reservation_id) REFERENCES reservations(id),
    FOREIGN KEY (redemption_id) REFERENCES reward_redemptions(id)
);

-- 19. notifications
CREATE TABLE notifications (
    id TEXT PRIMARY KEY,
    guest_id TEXT NOT NULL,
    reservation_id TEXT,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    type TEXT CHECK (type IN ('confirmation', 'reminder', 'promo')),
    is_read INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);
