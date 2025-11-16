#!/usr/bin/env python3
"""
C4 Framework Validation Script
Validates framework structure, naming conventions, and completeness
"""

import os
import re
import json
from pathlib import Path
from typing import List, Dict, Set

class FrameworkValidator:
    def __init__(self, framework_path: str):
        self.framework_path = Path(framework_path)
        self.errors: List[str] = []
        self.warnings: List[str] = []
        self.info: List[str] = []
        
    def validate(self) -> Dict[str, List[str]]:
        """Run all validation checks"""
        self.validate_structure()
        self.validate_naming_conventions()
        self.validate_archetype_completeness()
        self.validate_documentation()
        self.validate_styles()
        
        return {
            'errors': self.errors,
            'warnings': self.warnings,
            'info': self.info
        }
    
    def validate_structure(self):
        """Validate framework directory structure"""
        required_dirs = [
            'custom-archetypes',
            'persons',
            'systems',
            'containers',
            'components',
            'styles',
            'themes',
            'docs',
            'terminology'
        ]
        
        for dir_name in required_dirs:
            dir_path = self.framework_path / dir_name
            if not dir_path.exists():
                self.errors.append(f"Missing required directory: {dir_name}")
            elif not any(dir_path.iterdir()):
                self.warnings.append(f"Empty directory: {dir_name}")
        
        # Check for workspace.dsl
        workspace_file = self.framework_path / 'workspace.dsl'
        if not workspace_file.exists():
            self.errors.append("Missing workspace.dsl file")
    
    def validate_naming_conventions(self):
        """Validate file and archetype naming conventions"""
        dsl_files = list(self.framework_path.rglob('*.dsl'))
        
        for file_path in dsl_files:
            # Check file naming (kebab-case)
            filename = file_path.stem
            if not re.match(r'^[a-z0-9]+(-[a-z0-9]+)*$', filename):
                self.warnings.append(f"File name not in kebab-case: {file_path.name}")
            
            # Check archetype naming in file content
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    
                # Find archetype definitions (PascalCase)
                archetype_matches = re.findall(r'(\w+)\s*=\s*(?:person|softwareSystem|container|component)', content)
                for archetype in archetype_matches:
                    if not re.match(r'^[A-Z][a-zA-Z0-9]*$', archetype):
                        self.warnings.append(f"Archetype name not in PascalCase: {archetype} in {file_path.name}")
                        
            except Exception as e:
                self.warnings.append(f"Could not read file {file_path.name}: {str(e)}")
    
    def validate_archetype_completeness(self):
        """Validate that archetypes have required properties"""
        required_properties = {
            'softwareSystem': ['system.type', 'business.owner', 'technical.owner'],
            'container': ['technology'],
            'component': ['technology']
        }
        
        archetype_files = list(self.framework_path.glob('custom-archetypes/*.dsl'))
        
        for file_path in archetype_files:
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    
                # Check for required properties
                if 'properties {' in content:
                    for element_type, props in required_properties.items():
                        if element_type in content:
                            for prop in props:
                                if f'"{prop}"' not in content:
                                    self.warnings.append(f"Missing recommended property '{prop}' in {file_path.name}")
                else:
                    self.warnings.append(f"No properties block found in archetype: {file_path.name}")
                    
            except Exception as e:
                self.errors.append(f"Error reading archetype file {file_path.name}: {str(e)}")
    
    def validate_documentation(self):
        """Validate documentation completeness"""
        required_docs = [
            'EXTENSION_GUIDE.md',
            'FRAMEWORK_GOVERNANCE.md'
        ]
        
        docs_dir = self.framework_path / 'docs'
        if docs_dir.exists():
            existing_docs = [f.name for f in docs_dir.glob('*.md')]
            
            for doc in required_docs:
                if doc not in existing_docs:
                    self.warnings.append(f"Missing documentation: {doc}")
        else:
            self.errors.append("Missing docs directory")
    
    def validate_styles(self):
        """Validate style definitions"""
        styles_dir = self.framework_path / 'styles'
        if styles_dir.exists():
            style_files = list(styles_dir.glob('*.dsl'))
            if not style_files:
                self.warnings.append("No style files found")
            
            for style_file in style_files:
                try:
                    with open(style_file, 'r', encoding='utf-8') as f:
                        content = f.read()
                        
                    # Check for basic element styles
                    basic_elements = ['Person', 'Container', 'Component']
                    for element in basic_elements:
                        if f'element "{element}"' not in content:
                            self.warnings.append(f"Missing style for {element} in {style_file.name}")
                            
                except Exception as e:
                    self.errors.append(f"Error reading style file {style_file.name}: {str(e)}")

def main():
    """Main validation function"""
    import sys
    
    if len(sys.argv) != 2:
        print("Usage: python validate-framework.py <framework-path>")
        sys.exit(1)
    
    framework_path = sys.argv[1]
    validator = FrameworkValidator(framework_path)
    results = validator.validate()
    
    # Print results
    print("🔍 C4 Framework Validation Results")
    print("=" * 40)
    
    if results['errors']:
        print("\n❌ ERRORS:")
        for error in results['errors']:
            print(f"  • {error}")
    
    if results['warnings']:
        print("\n⚠️  WARNINGS:")
        for warning in results['warnings']:
            print(f"  • {warning}")
    
    if results['info']:
        print("\nℹ️  INFO:")
        for info in results['info']:
            print(f"  • {info}")
    
    if not results['errors'] and not results['warnings']:
        print("\n✅ Framework validation passed!")
    
    # Exit with error code if there are errors
    sys.exit(1 if results['errors'] else 0)

if __name__ == "__main__":
    main()
