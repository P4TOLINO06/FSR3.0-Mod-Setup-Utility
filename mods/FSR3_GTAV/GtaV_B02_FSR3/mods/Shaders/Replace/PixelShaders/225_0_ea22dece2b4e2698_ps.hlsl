// ---- FNV Hash ea22dece2b4e2698

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
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

cbuffer cascadeshadows_recieving_locals : register(b12)
{
  float4 gCSMShaderVars_deferred : packoffset(c0);
  float4 particleShadowsParams : packoffset(c1);
}

cbuffer cascadeshadows_rendering_locals : register(b11)
{
  row_major float4x4 viewToWorldProjectionParam : packoffset(c0);
  float4 perspectiveShearParam : packoffset(c4);
  float4 shadowParams2 : packoffset(c5);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState gCSMParticleShadowSamp_s : register(s2);
SamplerState depthBufferSamp_s : register(s3);
SamplerState gCSMDitherTextureSamp_s : register(s14);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> gCSMParticleShadowTexture : register(t2);
Texture2D<float4> depthBufferSamp : register(t3);
Texture2D<float4> gCSMDitherTextureSamp : register(t14);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float3 v3 : TEXCOORD2,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = depthBufferSamp.Sample(depthBufferSamp_s, v1.xy).xyzw;
  r0.y = 1 + viewToWorldProjectionParam._m33;
  r0.x = r0.y + -r0.x;
  r0.x = viewToWorldProjectionParam._m23 / r0.x;
  r0.yzw = v3.xyz * r0.xxx;
  r1.xy = globalScreenSize.xy * v1.xy;
  r1.xy = float2(0.015625,0.015625) * r1.xy;
  r1.xyzw = gCSMDitherTextureSamp.Sample(gCSMDitherTextureSamp_s, r1.xy).xyzw;
  r1.z = gCSMShaderVars_deferred.w * r1.z;
  r2.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xyw = r0.yzw * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r1.xyw;
  r3.xyz = r0.yzw * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r3.xyz;
  r4.xyz = r0.yzw * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r4.xyz;
  r0.yzw = r0.yzw * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r0.yzw;
  r3.zw = float2(5.5999999,1.39999998) * gCSMResolution.zw;
  r0.w = -gCSMResolution.z * 1.5 + 1;
  r0.w = r0.w * 0.5 + -r1.z;
  r1.z = max(abs(r4.x), abs(r4.y));
  r1.z = cmp(r1.z < r0.w);
  r1.z = r1.z ? 2 : 3;
  r1.w = max(abs(r3.x), abs(r3.y));
  r1.w = cmp(r1.w < r0.w);
  r1.z = r1.w ? 1 : r1.z;
  r1.x = max(abs(r1.x), abs(r1.y));
  r0.w = cmp(r1.x < r0.w);
  r0.w = r0.w ? 0 : r1.z;
  r1.xyz = x0[r0.w+0].xyz;
  r0.w = (int)r0.w;
  r1.w = 0.5 + r0.w;
  r1.w = 0.25 * r1.w;
  r4.xyzw = cmp(float4(0,1,2,3) == r0.wwww);
  r4.xyzw = r4.xyzw ? float4(1,1,1,1) : 0;
  r0.w = dot(r4.xyzw, gCSMDepthBias.xyzw);
  r3.x = dot(r4.xyzw, gCSMDepthSlopeBias.xyzw);
  r4.x = 0.5 + r1.x;
  r4.y = r1.y * 0.25 + r1.w;
  r1.x = cmp(r0.w != 0.000000);
  r0.w = r1.z + -r0.w;
  r5.xyw = ddx(r4.xyy);
  r5.z = ddx(r0.w);
  r6.xyz = ddy(r4.yxy);
  r6.w = ddy(r0.w);
  r1.yw = r6.yw * r5.yw;
  r7.xy = r5.xz * r6.xz + -r1.yw;
  r1.y = 1 / r7.x;
  r1.w = r6.y * r5.z;
  r7.z = r5.x * r6.w + -r1.w;
  r1.yw = r7.yz * r1.yy;
  r1.yw = max(float2(0,0), r1.yw);
  r1.yw = min(float2(0.5,0.5), r1.yw);
  r0.w = -r3.x * r1.y + r0.w;
  r0.w = -r3.x * r1.w + r0.w;
  r4.z = r1.x ? r0.w : r1.z;
  r1.xyzw = float4(-0.888000011,0.888000011,-0.77700001,-0.77700001) * r2.yxxy;
  r5.xy = float2(0.666000009,-0.666000009) * r2.yx;
  r6.xy = r3.zw * r2.xy;
  r6.z = 0;
  r6.xyz = r6.xyz + r4.xyz;
  r2.zw = -r2.yx;
  r7.xyzw = r3.zwzw * r2.zxyw;
  r8.xy = float2(0.5,0.5) * r7.xy;
  r8.z = 0;
  r8.xyz = r8.xyz + r4.xyz;
  r2.xy = r3.zw * -r2.xy;
  r2.xy = float2(0.75,0.75) * r2.xy;
  r2.z = 0;
  r2.xyz = r4.xyz + r2.xyz;
  r7.xy = float2(0.25,0.25) * r7.zw;
  r7.z = 0;
  r7.xyz = r7.xyz + r4.xyz;
  r9.xyzw = r3.zwzw * r1.zwxy;
  r10.xy = r9.zw;
  r10.z = 0;
  r10.xyz = r10.xyz + r4.xyz;
  r11.xyzw = float4(-1,1,1,-1) * r1.yxyx;
  r11.xyzw = r11.xyzw * r3.zwzw;
  r12.xy = float2(0.5,0.5) * r11.xy;
  r12.z = 0;
  r12.xyz = r12.xyz + r4.xyz;
  r13.xyzw = r3.zwzw * -r1.xyzw;
  r13.xyzw = float4(0.75,0.75,0.75,0.75) * r13.zwxy;
  r14.xy = r13.zw;
  r14.z = 0;
  r14.xyz = r14.xyz + r4.xyz;
  r11.xy = float2(0.25,0.25) * r11.zw;
  r11.z = 0;
  r11.xyz = r11.xyz + r4.xyz;
  r9.z = 0;
  r9.xyz = r9.xyz + r4.xyz;
  r1.xyzw = float4(-1,1,1,-1) * r1.wzwz;
  r1.xyzw = r3.zwzw * r1.xyzw;
  r15.xy = float2(0.5,0.5) * r1.xy;
  r15.z = 0;
  r15.xyz = r15.xyz + r4.xyz;
  r13.z = 0;
  r13.xyz = r13.xyz + r4.xyz;
  r1.xy = float2(0.25,0.25) * r1.zw;
  r1.z = 0;
  r1.xyz = r4.xyz + r1.xyz;
  r16.xy = r5.xy * r3.zw;
  r16.z = 0;
  r16.xyz = r16.xyz + r4.xyz;
  r5.zw = -r5.yx;
  r17.xyzw = r5.zxyw * r3.zwzw;
  r18.xy = float2(0.5,0.5) * r17.xy;
  r18.z = 0;
  r18.xyz = r18.xyz + r4.xyz;
  r3.xy = -r5.xy * r3.zw;
  r3.xy = float2(0.75,0.75) * r3.xy;
  r3.z = 0;
  r3.xyz = r4.xyz + r3.xyz;
  r5.xy = float2(0.25,0.25) * r17.zw;
  r5.z = 0;
  r5.xyz = r5.xyz + r4.xyz;
  r6.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r6.xy, r6.z).x;
  r6.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r8.z).x;
  r6.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r2.xy, r2.z).x;
  r6.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r7.xy, r7.z).x;
  r2.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r2.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r12.xy, r12.z).x;
  r2.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r2.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r11.xy, r11.z).x;
  r7.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r7.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r7.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r7.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r1.xy, r1.z).x;
  r1.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r1.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r3.xy, r3.z).x;
  r1.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r5.xy, r5.z).x;
  r2.xyzw = r6.xyzw + r2.xyzw;
  r2.xyzw = r2.xyzw + r7.xyzw;
  r1.xyzw = r2.xyzw + r1.xyzw;
  r0.w = dot(r1.xyzw, float4(1,1,1,1));
  r1.x = 0.0625 * r0.w;
  r0.w = cmp(particleShadowsParams.x != 0.000000);
  if (r0.w != 0) {
    r2.xyzw = gCSMParticleShadowTexture.Sample(gCSMParticleShadowSamp_s, r4.xy).xyzw;
    r1.y = 1 + -r2.w;
  } else {
    r1.y = 1;
  }
  r0.x = saturate(r0.x * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r0.y = max(abs(r0.y), abs(r0.z));
  r0.y = saturate(r0.y * 15 + -6.30000019);
  r0.x = 1 + -r0.x;
  r0.xy = r0.xx * r0.yy + r1.xy;
  r0.xy = r0.xy * r0.xy;
  r0.yz = min(float2(1,1), r0.xy);
  r0.w = cmp(0 != particleShadowsParams.y);
  r1.x = r0.y * r0.z;
  r0.x = r0.w ? r1.x : r0.y;
  o0.xyzw = r0.xzzz;
  return;
}