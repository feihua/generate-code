<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "https://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="{{.PackageName}}.dao.{{.JavaName}}Dao">

    <resultMap id="BaseResultMap" type="{{.PackageName}}.entity.{{.JavaName}}Bean">
    {{range .TableColumn}}  <result column="{{.ColumnName}}" property="{{.JavaName}}" jdbcType="{{.JdbcType}}"/>
    {{end}}
    </resultMap>

    <sql id="Base_Column_List">
        {{.AllColumns}}
    </sql>

    <!--添加{{.Comment}}-->
    <insert id="add{{.JavaName}}" parameterType="{{.PackageName}}.entity.{{.JavaName}}Bean">
        insert into {{.OriginalName}}
        <trim prefix="(" suffix=")" suffixOverrides=",">{{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                {{.ColumnName}},
            </if>{{end}}
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">{{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                #{ {{.JavaName}},jdbcType={{.JdbcType}} },
            </if>{{end}}
        </trim>
    </insert>

    <!--删除{{.Comment}}-->
    <delete id="delete{{.JavaName}}">
        delete from {{.OriginalName}} where id in
        <foreach collection="list" item="id" index="index"
            open="(" close=")" separator=",">
            #{id}
        </foreach>
    </delete>

    <!--更新{{.Comment}}-->
    <update id="update{{.JavaName}}" parameterType="{{.PackageName}}.entity.{{.JavaName}}Bean">
        update {{.OriginalName}}
        <set>{{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                {{.ColumnName}} = #{ {{.JavaName}},jdbcType={{.JdbcType}}},
            </if>{{end}}
        </set>
        <where> {{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                and {{.ColumnName}} = #{ {{.JavaName}}}
            </if>{{end}}
        </where>
    </update>

    <!--更新{{.Comment}}状态-->
    <update id="update{{.JavaName}}Status" parameterType="{{.PackageName}}.entity.{{.JavaName}}Bean">
        update {{.OriginalName}}
        <set>{{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                {{.ColumnName}} = #{ {{.JavaName}},jdbcType={{.JdbcType}}},
            </if>{{end}}
        </set>
        <where> {{range .TableColumn}}
            <if test="{{.JavaName}} != null">
                and {{.ColumnName}} = #{ {{.JavaName}}}
            </if>{{end}}
        </where>
    </update>

    <!--查询{{.Comment}}详情-->
    <select id="query{{.JavaName}}Detail" parameterType="{{.PackageName}}.entity.{{.JavaName}}Bean" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from {{.OriginalName}}
        <where>{{range .TableColumn}}
        <!--<if test="{{.JavaName}} != null">-->
        <!--    and {{.ColumnName}} = #{ {{.JavaName}}}-->
        <!--</if>-->{{end}}
        </where>
    </select>

    <!--根据id查询{{.Comment}}详情-->
    <select id="query{{.JavaName}}ById" parameterType="java.lang.Long" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from {{.OriginalName}} where id = #{id}
    </select>

    <!--查询{{.Comment}}列表-->
    <select id="query{{.JavaName}}List" parameterType="{{.PackageName}}.entity.{{.JavaName}}Bean" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from {{.OriginalName}}
        <where>{{range .TableColumn}}
          <!--<if test="{{.JavaName}} != null">-->
          <!--    and {{.ColumnName}} = #{ {{.JavaName}}}-->
          <!--</if>-->{{end}}
        </where>
    </select>
</mapper>
