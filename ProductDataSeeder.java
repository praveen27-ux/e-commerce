package com.webspeak.config;

import com.webspeak.mongo.ProductDocument;
import com.webspeak.mongo.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Configuration
public class ProductDataSeeder {

    @Bean
    public CommandLineRunner seedProductsIfEmpty(ProductRepository productRepository) {
        return args -> {
            if (productRepository.count() > 0) {
                return;
            }

            LocalDateTime now = LocalDateTime.now();

            // ProductDocument is a simple @Data model (no builder usage required).
            List<ProductDocument> seed = Arrays.asList(
                make(
                    "spk-bass-pro-40w",
                    "BassX Pro 40W Bluetooth Speaker",
                    "Bluetooth Speakers",
                    2499d,
                    15d,
                    50,
                    "https://images.unsplash.com/photo-1518441902117-f0a9c8d56e0a?w=800&auto=format&fit=crop&q=60",
                    true,
                    "hero",
                    now
                ),
                make(
                    "spk-party-rgb-60w",
                    "PartyPulse RGB 60W Speaker",
                    "Party Speakers",
                    4999d,
                    20d,
                    35,
                    "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800&auto=format&fit=crop&q=60",
                    true,
                    "mid",
                    now
                ),
                make(
                    "spk-home-audio-mini",
                    "HomeAudio Mini 25W",
                    "Home Audio",
                    1299d,
                    10d,
                    80,
                    "https://images.unsplash.com/photo-1519764622345-8f0e9f3e2e7a?w=800&auto=format&fit=crop&q=60",
                    true,
                    "mid",
                    now
                ),
                make(
                    "spk-smart-voice-80w",
                    "SmartVoice 80W AI Speaker",
                    "Smart Speakers",
                    7999d,
                    25d,
                    20,
                    "https://images.unsplash.com/photo-1604654893781-0bdbccbf8a4f?w=800&auto=format&fit=crop&q=60",
                    true,
                    "hero",
                    now
                ),
                make(
                    "sb-dolby-sound-120",
                    "DolbySound 120 Soundbar",
                    "Soundbars",
                    9999d,
                    18d,
                    15,
                    "https://images.unsplash.com/photo-1583869585467-62b9d1e89d3d?w=800&auto=format&fit=crop&q=60",
                    true,
                    "mid",
                    now
                )
            );

            productRepository.saveAll(seed);
        };
    }

    private static ProductDocument make(
        String id,
        String name,
        String category,
        Double price,
        Double discountPct,
        Integer stock,
        String imageUrl,
        Boolean enabled,
        String bannerType,
        LocalDateTime now
    ) {
        ProductDocument p = new ProductDocument();
        // Lombok @Data is expected to generate setters, but to be safe at compile-time,
        // use reflection-free direct field assignment.
        p.setId(id);
        p.setName(name);
        p.setCategory(category);
        p.setPrice(price);
        p.setDiscountPct(discountPct);
        p.setStock(stock);
        p.setImageUrl(imageUrl);
        p.setEnabled(enabled);
        p.setBannerType(bannerType);
        p.setCreatedAt(now);
        p.setUpdatedAt(now);
        return p;

    }
}

