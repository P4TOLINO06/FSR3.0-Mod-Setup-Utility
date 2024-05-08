// ---- FNV Hash 113e09db1f60d55a

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

cbuffer water_globals : register(b4)
{
  float2 gWorldBaseVS : packoffset(c0);
  float4 gFlowParams : packoffset(c1);
  float4 gFlowParams2 : packoffset(c2);
  float4 gWaterAmbientColor : packoffset(c3);
  float4 gWaterDirectionalColor : packoffset(c4);
  float4 gScaledTime : packoffset(c5);
  float4 gOceanParams0 : packoffset(c6);
  float4 gOceanParams1 : packoffset(c7);
  row_major float4x4 gReflectionWorldViewProj : packoffset(c8);
  float4 gFogLight_Debugging : packoffset(c12);
  row_major float4x4 gRefractionWorldViewProj : packoffset(c13);
  float4 gOceanParams2 : packoffset(c17);
}

cbuffer water_locals : register(b11)
{
  float4 OceanLocalParams0 : packoffset(c0);
  float4 FogParams : packoffset(c1);
  float4 QuadAlpha : packoffset(c2);
  float3 CameraPosition : packoffset(c3);
}

SamplerState StaticBumpSampler_s : register(s2);
SamplerState FogSampler_s : register(s3);
SamplerState NoiseSampler_s : register(s5);
SamplerState RefractionDepthSampler_s : register(s11);
SamplerState RefractionSampler_s : register(s12);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> StaticBumpSampler : register(t2);
Texture2D<float4> FogSampler : register(t3);
Texture2D<float4> NoiseSampler : register(t5);
Texture2D<float4> RefractionDepthSampler : register(t11);
Texture2D<float4> RefractionSampler : register(t12);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r0.xyz = r0.xyz / v3.www;
  r1.xy = v1.xy / v3.ww;
  r1.zw = gOceanParams0.xy * r1.xy;
  r2.xyzw = RefractionDepthSampler.Sample(RefractionDepthSampler_s, r1.xy).xyzw;
  r0.w = -v3.w + r2.x;
  o1.y = max(0, r0.w);
  r1.xyzw = NoiseSampler.Sample(NoiseSampler_s, r1.zw).xyzw;
  r0.w = 3.1400001 * r1.x;
  sincos(r0.w, r2.x, r3.x);
  r2.y = r3.x;
  r2.xy = float2(0.100000001,0.100000001) * r2.xy;
  r2.z = 0;
  r0.xyz = r2.xyz + r0.xyz;
  r0.xyz = r0.xyz * r1.xxx;
  r0.xyz = r0.xyz * float3(5,5,5) + v3.xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r2.xyz = gCSMShaderVars_shared[1].xyz * r1.yyy;
  r1.xyw = r1.xxx * gCSMShaderVars_shared[0].xyz + r2.xyz;
  r1.xyz = r1.zzz * gCSMShaderVars_shared[2].xyz + r1.xyw;
  r2.xyz = r1.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r2.xyz;
  r0.z = max(abs(r2.x), abs(r2.y));
  r2.xyz = r1.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r2.xyz;
  r0.w = max(abs(r2.x), abs(r2.y));
  r2.xyz = r1.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  r1.xyz = r1.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[2].xyz = r2.xyz;
  r1.w = max(abs(r2.x), abs(r2.y));
  x0[3].xyz = r1.xyz;
  r1.x = max(abs(r1.x), abs(r1.y));
  r1.x = saturate(r1.x * 15 + -6.30000019);
  r1.y = -gCSMResolution.z * 1.5 + 1;
  r1.y = 0.5 * r1.y;
  r1.z = cmp(r1.w < r1.y);
  r1.z = r1.z ? 2 : 3;
  r0.zw = cmp(r0.zw < r1.yy);
  r0.w = r0.w ? 1 : r1.z;
  r0.z = r0.z ? 0 : r0.w;
  r0.w = (int)r0.z;
  r1.yzw = x0[r0.z+0].xyz;
  r0.z = 0.5 + r0.w;
  r2.xyzw = cmp(float4(0,1,2,3) == r0.wwww);
  r2.xyzw = r2.xyzw ? float4(1,1,1,1) : 0;
  r0.z = 0.25 * r0.z;
  r3.y = r1.z * 0.25 + r0.z;
  r3.x = 0.5 + r1.y;
  r4.xyw = ddx(r3.xyy);
  r0.z = dot(r2.xyzw, gCSMDepthBias.xyzw);
  r0.w = dot(r2.xyzw, gCSMDepthSlopeBias.xyzw);
  r1.y = r1.w + -r0.z;
  r0.z = cmp(r0.z != 0.000000);
  r4.z = ddx(r1.y);
  r2.xyz = ddy(r3.yxy);
  r2.w = ddy(r1.y);
  r3.zw = r4.yw * r2.yw;
  r5.xy = r4.xz * r2.xz + -r3.zw;
  r1.z = r4.z * r2.y;
  r5.z = r4.x * r2.w + -r1.z;
  r1.z = 1 / r5.x;
  r2.xy = r5.yz * r1.zz;
  r2.xy = max(float2(0,0), r2.xy);
  r2.xy = min(float2(0.5,0.5), r2.xy);
  r1.y = -r0.w * r2.x + r1.y;
  r0.w = -r0.w * r2.y + r1.y;
  r0.z = r0.z ? r0.w : r1.w;
  r0.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r3.xy, r0.z).x;
  r0.w = saturate(v3.w * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r0.w = 1 + -r0.w;
  r0.z = r0.w * r1.x + r0.z;
  r0.z = r0.z * r0.z;
  r0.z = min(1, r0.z);
  r1.x = -gFlowParams2.w;
  r1.yw = float2(-0,0.5);
  r1.xy = r0.xy * float2(0.000285714283,0.000285714283) + r1.xy;
  r0.xy = -FogParams.xy + r0.xy;
  r2.xyzw = StaticBumpSampler.Sample(StaticBumpSampler_s, r1.xy).xyzw;
  r1.z = r2.y;
  r1.xyzw = RefractionSampler.Sample(RefractionSampler_s, r1.zw).xyzw;
  o0.w = r1.x * r0.z;
  r0.x = FogParams.z * r0.x;
  r0.z = -r0.y * FogParams.w + 1;
  r0.xyzw = FogSampler.Sample(FogSampler_s, r0.xz).xyzw;
  o0.xyz = r0.xyz;
  o1.x = v2.w;
  o1.zw = float2(0,0);
  return;
}