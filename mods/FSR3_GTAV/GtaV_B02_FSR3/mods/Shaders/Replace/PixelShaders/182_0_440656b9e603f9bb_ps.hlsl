// ---- FNV Hash 440656b9e603f9bb

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

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

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer vehiclecommonlocals : register(b11)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 dirtLevelMod : packoffset(c2);
  float specularFresnel : packoffset(c3);
  float specularFalloffMult : packoffset(c3.y);
  float specularIntensityMult : packoffset(c3.z);
  float3 specMapIntMask : packoffset(c4);
  float bumpiness : packoffset(c4.w);
  float reflectivePower : packoffset(c5);
  float envEffThickness : packoffset(c5.y);
  float2 envEffScale : packoffset(c5.z);
  float envEffTexTileUV : packoffset(c6);
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

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState BumpSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> BumpSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear sample float4 v0 : TEXCOORD0,
  linear sample float4 v1 : TEXCOORD1,
  linear sample float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  linear sample float4 v4 : TEXCOORD4,
  linear sample float4 v5 : TEXCOORD5,
  linear sample float4 v6 : TEXCOORD6,
  float4 v7 : SV_Position0,
  float4 v8 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v0.xy).xyzw;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v0.xy).xyzw;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.ww;
  r2.xyz = v5.xyz * r1.yyy;
  r1.xyw = r1.xxx * v4.xyz + r2.xyz;
  r1.xyz = r1.zzz * v1.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r3.xyzw = SpecSampler.Sample(SpecSampler_s, v0.xy).xyzw;
  r3.xy = r3.xy * r3.xy;
  r1.x = dot(r3.xyz, specMapIntMask.xyz);
  r1.x = specularIntensityMult * r1.x;
  r0.xyz = matDiffuseColor.xyz * r0.xyz;
  r0.xyzw = v6.xxxw * r0.xyzw;
  r3.xy = globalScalars.zy * v6.xx;
  r1.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.y = r3.y * r1.y;
  r1.x = v6.x * r1.x;
  r1.x = v1.w * r1.x;
  r1.x = saturate(dirtLevelMod.z * r1.x);
  r0.xyz = r0.xyz * r0.xyz;
  r4.xyz = gViewInverse._m30_m31_m32 + -v2.xyz;
  r2.w = dot(r4.xyz, r4.xyz);
  r2.w = rsqrt(r2.w);
  r5.xyz = r4.xyz * r2.www;
  r6.xyz = r4.xyz * r2.www + -gDirectionalLight.xyz;
  r2.w = dot(r6.xyz, r6.xyz);
  r2.w = rsqrt(r2.w);
  r6.xyz = r6.xyz * r2.www;
  r2.w = r3.x * r3.x;
  r1.y = r1.y * r1.y;
  r3.x = r3.w * specularFalloffMult + -500;
  r3.x = max(0, r3.x);
  r3.y = r3.w * specularFalloffMult + -r3.x;
  r3.x = 558 * r3.x;
  r3.x = r3.y * 3 + r3.x;
  r3.y = dot(r4.xyz, gViewInverse._m20_m21_m22);
  r4.xyz = -gViewInverse._m30_m31_m32 + v2.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r4.yyy;
  r7.xyz = r4.xxx * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r7.xyz = r4.zzz * gCSMShaderVars_shared[2].xyz + r7.xyz;
  r8.xyz = r7.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r8.xyz;
  r9.xyz = r7.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r9.xyz;
  r10.xyz = r7.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r10.xyz;
  r7.xyz = r7.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r7.xyz;
  r11.yw = float2(-0.346096486,0.32848981) * gCSMResolution.zw;
  r3.z = -gCSMResolution.z * 1.5 + 1;
  r3.z = 0.5 * r3.z;
  r3.w = max(abs(r10.x), abs(r10.y));
  r3.w = cmp(r3.w < r3.z);
  r3.w = r3.w ? 2 : 3;
  r4.w = max(abs(r9.x), abs(r9.y));
  r4.w = cmp(r4.w < r3.z);
  r3.w = r4.w ? 1 : r3.w;
  r4.w = max(abs(r8.x), abs(r8.y));
  r3.z = cmp(r4.w < r3.z);
  r3.z = r3.z ? 0 : r3.w;
  r8.xyz = x0[r3.z+0].xyz;
  r3.z = (int)r3.z;
  r3.w = 0.5 + r3.z;
  r3.w = 0.25 * r3.w;
  r9.xyzw = cmp(float4(0,1,2,3) == r3.zzzz);
  r9.xyzw = r9.xyzw ? float4(1,1,1,1) : 0;
  r3.z = dot(r9.xyzw, gCSMDepthBias.xyzw);
  r4.w = dot(r9.xyzw, gCSMDepthSlopeBias.xyzw);
  r9.x = 0.5 + r8.x;
  r9.y = r8.y * 0.25 + r3.w;
  r3.w = cmp(r3.z != 0.000000);
  r3.z = r8.z + -r3.z;
  r10.xyw = ddx(r9.xyy);
  r10.z = ddx(r3.z);
  r12.xyz = ddy(r9.yxy);
  r12.w = ddy(r3.z);
  r7.zw = r12.yw * r10.yw;
  r13.xy = r10.xz * r12.xz + -r7.zw;
  r5.w = 1 / r13.x;
  r6.w = r12.y * r10.z;
  r13.z = r10.x * r12.w + -r6.w;
  r7.zw = r13.yz * r5.ww;
  r7.zw = max(float2(0,0), r7.zw);
  r7.zw = min(float2(0.5,0.5), r7.zw);
  r3.z = -r4.w * r7.z + r3.z;
  r3.z = -r4.w * r7.w + r3.z;
  r11.z = r3.w ? r3.z : r8.z;
  r9.z = 0;
  r8.xyz = r11.ywz + r9.xyz;
  r11.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r10.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0311755091,0.1793378) * gCSMResolution.zw;
  r12.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.514749527,0.253502488) * gCSMResolution.zw;
  r13.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r14.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r15.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.54554671,0.0241285395) * gCSMResolution.zw;
  r16.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0289061107,-0.136784598) * gCSMResolution.zw;
  r17.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.479511499,-0.244832903) * gCSMResolution.zw;
  r18.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r19.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.339352608,-0.249327794) * gCSMResolution.zw;
  r20.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.07059801,0.208122596) * gCSMResolution.zw;
  r21.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.29403806,-0.0180776808) * gCSMResolution.zw;
  r22.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.747563124,-0.113974303) * gCSMResolution.zw;
  r23.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.94772172,-0.248763502) * gCSMResolution.zw;
  r24.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-1.343153,-0.088584058) * gCSMResolution.zw;
  r9.xyz = r11.xyz + r9.xyz;
  r8.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r8.z).x;
  r8.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r8.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r12.xy, r12.z).x;
  r8.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r10.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r10.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r10.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r10.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r17.xy, r17.z).x;
  r11.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r11.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r19.xy, r19.z).x;
  r11.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r20.xy, r20.z).x;
  r11.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r21.xy, r21.z).x;
  r12.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r22.xy, r22.z).x;
  r12.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r23.xy, r23.z).x;
  r12.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r24.xy, r24.z).x;
  r12.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r8.xyzw = r10.xyzw + r8.xyzw;
  r8.xyzw = r8.xyzw + r11.xyzw;
  r8.xyzw = r8.xyzw + r12.xyzw;
  r3.z = dot(r8.xyzw, float4(1,1,1,1));
  r3.y = saturate(r3.y * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r3.w = max(abs(r7.x), abs(r7.y));
  r3.w = saturate(r3.w * 15 + -6.30000019);
  r3.y = 1 + -r3.y;
  r3.y = r3.y * r3.w;
  r3.y = r3.z * 0.0625 + r3.y;
  r3.y = r3.y * r3.y;
  r3.y = min(1, r3.y);
  r3.z = saturate(v2.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r3.z = sqrt(r3.z);
  r3.z = gCSMShaderVars_shared[3].z * r3.z;
  r3.y = r3.z * -r3.y + r3.y;
  r3.z = saturate(dot(r2.xyz, -gDirectionalLight.xyz));
  r7.x = saturate(dot(r5.xyz, r2.xyz));
  r7.y = saturate(dot(r6.xyz, -gDirectionalLight.xyz));
  r7.xy = float2(1,1) + -r7.xy;
  r7.zw = r7.xy * r7.xy;
  r7.zw = r7.zw * r7.zw;
  r7.xy = r7.zw * r7.xy;
  r3.w = 1 + -specularFresnel;
  r7.xy = specularFresnel * r7.xy + r3.ww;
  r7.zw = float2(2,9.99999994e-09) + r3.xx;
  r3.w = 0.125 * r7.z;
  r4.w = -r1.x * r7.x + 1;
  r5.w = dot(r2.xyz, r6.xyz);
  r5.w = saturate(9.99999994e-09 + r5.w);
  r5.w = log2(r5.w);
  r5.w = r7.w * r5.w;
  r5.w = exp2(r5.w);
  r5.w = r5.w * r7.y;
  r3.w = r5.w * r3.w;
  r1.x = r3.w * r1.x;
  r1.x = r1.x * r3.z;
  r3.z = r4.w * r3.z;
  r6.xyz = r0.xyz * r3.zzz + r1.xxx;
  r6.xyz = gDirectionalColour.xyz * r6.xyz;
  r1.x = r1.z * r1.w + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r7.xyz = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r1.z = 1 + -globalScalars2.z;
  r8.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r8.xyz = globalScalars2.zzz * r8.xyz;
  r7.xyz = r7.xyz * r1.zzz + r8.xyz;
  r7.xyz = r7.xyz * r1.yyy;
  r1.xzw = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r8.x = gLightArtificialIntAmbient1.w;
  r8.y = gLightArtificialExtAmbient0.w;
  r8.z = gLightArtificialExtAmbient1.w;
  r3.z = saturate(dot(r8.xyz, r2.xyz));
  r1.xzw = gDirectionalAmbientColour.xyz * r3.zzz + r1.xzw;
  r1.xzw = r1.xzw * r2.www + r7.xyz;
  r1.xzw = r1.xzw * r4.www;
  r0.xyz = r1.xzw * r0.xyz;
  r0.xyz = r6.xyz * r3.yyy + r0.xyz;
  r1.x = 1 + -r4.w;
  r1.z = dot(-r5.xyz, r2.xyz);
  r1.z = r1.z + r1.z;
  r2.xyz = r2.xyz * -r1.zzz + -r5.xyz;
  r1.zw = saturate(float2(0.000666666718,0.00177619897) * r3.xx);
  r1.z = 1 + -r1.z;
  r3.x = -5 + gReflectionMipCount;
  r3.y = gReflectionMipCount * r1.z;
  r3.y = cmp(r3.y < r3.x);
  r3.z = r1.z * gReflectionMipCount + -5;
  r1.z = r1.z * r1.z;
  r1.z = r1.z * 5 + r3.x;
  r1.z = r3.y ? r3.z : r1.z;
  r3.xyz = float3(-0.25,0.5,0.25) * r2.xyx;
  r2.x = 1 + abs(r2.z);
  r3.xyz = r3.xyz / r2.xxx;
  r3.xyz = float3(0.75,0.5,0.25) + -r3.xyz;
  r2.x = cmp(0 < r2.z);
  r2.xy = r2.xx ? r3.xy : r3.zy;
  r3.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r2.xy, r1.z).xyzw;
  r1.y = max(r2.w, r1.y);
  r2.xyz = r3.xyz * r1.yyy;
  r1.yzw = r2.xyz * r1.www;
  r1.yzw = float3(0.681690097,0.681690097,0.681690097) * r1.yzw;
  r1.yzw = r2.xyz * float3(0.318309903,0.318309903,0.318309903) + r1.yzw;
  r0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = saturate(globalScalars.x * r0.w);
  r0.w = dot(r4.xyz, r4.xyz);
  r1.x = sqrt(r0.w);
  r1.y = -globalFogParams[0].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r1.x = r4.z * r1.x;
  r1.z = globalFogParams[2].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.w = -1.44269502 * r1.z;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r1.z = r1.w / r1.z;
  r1.x = r1.x ? r1.z : 1;
  r1.z = globalFogParams[1].w * r1.y;
  r1.x = r1.z * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.z = globalFogParams[2].y * r1.x;
  r0.w = rsqrt(r0.w);
  r2.xyz = r4.xyz * r0.www;
  r0.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
  r0.w = log2(r0.w);
  r0.w = globalFogParams[4].w * r0.w;
  r0.w = exp2(r0.w);
  r1.w = saturate(dot(r2.xyz, globalFogParams[3].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[3].w * r1.w;
  r1.w = exp2(r1.w);
  r1.x = -r1.x * globalFogParams[2].y + 1;
  r1.x = globalFogParams[1].y * r1.x;
  r2.x = -globalFogParams[2].x + r1.y;
  r2.x = max(0, r2.x);
  r2.x = globalFogParams[1].x * r2.x;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  r1.z = saturate(r1.x * r2.x + r1.z);
  r1.y = -globalFogParams[1].z * r1.y;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r0.www * r2.xyz + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.xyz;
  r2.xyz = r1.www * r3.xyz + r2.xyz;
  r2.xyz = -globalFogColorN.xyz + r2.xyz;
  r2.xyz = r1.yyy * r2.xyz + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r2.x;
  r3.y = globalFogColorE.w + -r2.y;
  r3.z = globalFogColorN.w + -r2.z;
  r1.xyw = r1.xxx * r3.xyz + r2.xyz;
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r2.xy = globalScreenSize.zw * v7.xy;
    r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
    r0.w = -1 + r2.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
  } else {
    r0.w = 1;
  }
  r1.xyw = r1.xyw * r0.www + -r0.xyz;
  r0.xyz = r1.zzz * r1.xyw + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  return;
}