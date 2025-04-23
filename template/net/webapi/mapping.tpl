using AutoMapper;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Dto.Response.{{.ModuleName}}.{{.JavaName}};
using core_admin.Models.{{.ModuleName}};

namespace core_admin.Mappings.{{.ModuleName}};

/// <summary>
/// {{.Comment}}mapping
/// </summary>
public class {{.JavaName}}MappingProfile : Profile {
    public {{.JavaName}}MappingProfile() {
        CreateMap<Sys{{.JavaName}}, {{.JavaName}}DetailVo>().ForMember(dest => dest.CreateTime,
                opt => opt.MapFrom(src => src.CreateTime.ToString("yyyy-MM-dd HH:mm:ss")))
            .ForMember(dest => dest.UpdateTime,
                opt => opt.MapFrom(src => src.UpdateTime.HasValue
                    ? src.UpdateTime.Value.ToString("yyyy-MM-dd HH:mm:ss")
                    : null));
        CreateMap<Add{{.JavaName}}Dto, Sys{{.JavaName}}>();
        CreateMap<Update{{.JavaName}}Dto, Sys{{.JavaName}}>();
        CreateMap<Sys{{.JavaName}}, {{.JavaName}}ListVo>().ForMember(dest => dest.CreateTime,
              opt => opt.MapFrom(src => src.CreateTime.ToString("yyyy-MM-dd HH:mm:ss")))
          .ForMember(dest => dest.UpdateTime,
              opt => opt.MapFrom(src => src.UpdateTime.HasValue
                  ? src.UpdateTime.Value.ToString("yyyy-MM-dd HH:mm:ss")
                  : null));
    }
}