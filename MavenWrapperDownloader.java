package org.apache.maven.wrapper;

import java.io.*;
import java.net.*;
import java.nio.channels.*;
import java.nio.file.*;

public class MavenWrapperDownloader {

    private static final String WRAPPER_PROPERTIES_PATH = ".mvn/wrapper/maven-wrapper.properties";

    public static void main(String[] args) throws Exception {
        File baseDir = new File(args[0]);
        File wrapperJar = new File(baseDir, ".mvn/wrapper/maven-wrapper.jar");
        if (wrapperJar.exists()) {
            System.out.println("maven-wrapper.jar already exists");
            return;
        }

        Path wrapperProperties = baseDir.toPath().resolve(WRAPPER_PROPERTIES_PATH);
        Properties props = new Properties();
        try (InputStream in = Files.newInputStream(wrapperProperties)) {
            props.load(in);
        }

        String wrapperUrl = props.getProperty("wrapperUrl");
        if (wrapperUrl == null || wrapperUrl.trim().isEmpty()) {
            throw new IllegalStateException("wrapperUrl is not set in " + wrapperProperties);
        }

        System.out.println("Downloading Maven wrapper jar from: " + wrapperUrl);
        URL url = new URL(wrapperUrl);
        Files.createDirectories(wrapperJar.getParentFile().toPath());

        try (ReadableByteChannel rbc = Channels.newChannel(url.openStream());
             FileOutputStream fos = new FileOutputStream(wrapperJar)) {
            fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        }

        System.out.println("Downloaded Maven wrapper jar to: " + wrapperJar);
    }
}

