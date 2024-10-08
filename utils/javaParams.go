package utils

type Project struct {
	ArtifactId string
	GroupId    string
	Author     string
	CreateTime string
}

type Eureka struct {
	ParentArtifactId string
	ArtifactId       string
	GroupId          string
	PackageName      string
	CreateTime       string
	Author           string
}

type Gateway struct {
	ParentArtifactId string
	ArtifactId       string
	GroupId          string
	PackageName      string
	CreateTime       string
	Author           string
}

type Modules struct {
	ParentArtifactId string
	ArtifactId       string
	GroupId          string
	PackageName      string
	CreateTime       string
	Author           string
	MapperPath       string
}
