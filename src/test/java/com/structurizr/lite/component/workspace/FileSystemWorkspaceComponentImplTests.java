package com.structurizr.lite.component.workspace;

import com.structurizr.Workspace;
import com.structurizr.lite.Configuration;
import com.structurizr.lite.component.search.SearchComponent;
import com.structurizr.lite.component.search.SearchResult;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class FileSystemWorkspaceComponentImplTests {

    private static class NoopSearchComponent implements SearchComponent {
        @Override
        public void index(Workspace workspace) {
        }

        @Override
        public List<SearchResult> search(String query, String type) {
            return Collections.emptyList();
        }
    }

    @Test
    void getImage_ThrowsException_WhenRequestingAFileThatIsNotAnImage() throws Exception {
        Path tmpdir = Files.createTempDirectory(Paths.get("build"), getClass().getSimpleName());
        Configuration.init(tmpdir.toFile());
        WorkspaceComponent workspaceComponent = new FileSystemWorkspaceComponentImpl(
            new NoopSearchComponent(), 
            new C4FrameworkService()
        );

        try {
            workspaceComponent.getImage(1, "xss.js");
            fail();
        } catch (WorkspaceComponentException e) {
            assertEquals("xss.js is not an image", e.getMessage());
        }
    }

    @Test
    void putImage_ThrowsException_WhenPuttingAFileThatIsNotAnImage() throws Exception {
        Path tmpdir = Files.createTempDirectory(Paths.get("build"), getClass().getSimpleName());
        Configuration.init(tmpdir.toFile());
        WorkspaceComponent workspaceComponent = new FileSystemWorkspaceComponentImpl(
            new NoopSearchComponent(), 
            new C4FrameworkService()
        );

        try {
            workspaceComponent.putImage(1, "xss.js", "data:text/javascript;base64,YWxlcnQoJ1hTUycpOw==");
            fail();
        } catch (WorkspaceComponentException e) {
            assertEquals("xss.js is not an image", e.getMessage());
        }
    }

}
