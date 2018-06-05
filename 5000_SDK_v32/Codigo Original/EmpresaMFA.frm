
[Forma]
Clave=EmpresaMFA
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=<T>MFA - Configuración Empresas<T>
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=DatosGenerales
PosicionInicialAlturaCliente=421
PosicionInicialAncho=677
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=403
PosicionInicialArriba=143
DialogoAbrir=S

Menus=S
ListaAcciones=(Lista)
MenuPrincipal=&Archivo
[Lista.Columnas]
Empresa=71
Impuesto2=106



EjercicioInicial=73
PeriodoInicial=74

CobrosConciliados=98
PagosConciliados=91
AnticiposPagadosPeriodo=130
IncluirNomina=128





Nombre=293
Cliente=117
RFC=107
[Lista.ListaEnCaptura]
(Inicio)=EmpresaMFA.Empresa
EmpresaMFA.Empresa=EmpresaMFA.Impuesto2
EmpresaMFA.Impuesto2=EmpresaMFA.EjercicioInicial
EmpresaMFA.EjercicioInicial=EmpresaMFA.PeriodoInicial
EmpresaMFA.PeriodoInicial=EmpresaMFA.CobrosConciliados
EmpresaMFA.CobrosConciliados=EmpresaMFA.PagosConciliados
EmpresaMFA.PagosConciliados=EmpresaMFA.AnticiposPagadosPeriodo
EmpresaMFA.AnticiposPagadosPeriodo=EmpresaMFA.IncluirNomina
EmpresaMFA.IncluirNomina=(Fin)


[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EmpresaMFAA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Empresa<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Empresa
ListaEnCaptura=Empresa.Nombre
MenuLocal=S
ListaAcciones=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosConPaginas=S
IconosNombre=EmpresaMFAA:EmpresaMFA.Empresa
[(Carpeta Abrir).Columnas]
0=79

1=327
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
[(Carpeta Abrir).Empresa.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

EspacioPrevio=S









[DatosGenerales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=DatosGenerales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[DatosGenerales.EmpresaMFA.Empresa]
Carpeta=DatosGenerales
Clave=EmpresaMFA.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[DatosGenerales.EmpresaMFA.Impuesto2]
Carpeta=DatosGenerales
Clave=EmpresaMFA.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[DatosGenerales.EmpresaMFA.EjercicioInicial]
Carpeta=DatosGenerales
Clave=EmpresaMFA.EjercicioInicial
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[DatosGenerales.EmpresaMFA.PeriodoInicial]
Carpeta=DatosGenerales
Clave=EmpresaMFA.PeriodoInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[DatosGenerales.EmpresaMFA.CobrosConciliados]
Carpeta=DatosGenerales
Clave=EmpresaMFA.CobrosConciliados
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=35
EspacioPrevio=S
[DatosGenerales.EmpresaMFA.PagosConciliados]
Carpeta=DatosGenerales
Clave=EmpresaMFA.PagosConciliados
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=35
[DatosGenerales.Columnas]
Empresa=45
Impuesto2=64
EjercicioInicial=73
PeriodoInicial=70
CobrosConciliados=94
PagosConciliados=89
AnticiposPagadosPeriodo=130
IncluirNomina=133


[DatosGenerales.Empresa.Nombre]
Carpeta=DatosGenerales
Clave=Empresa.Nombre
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco








[CXC]
Estilo=Ficha
Pestana=S
Clave=CXC
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
PermiteEditar=S
PestanaOtroNombre=S
PestanaNombre=Cxc
[CXC.EmpresaMFA.AnticiposPagadosPeriodo]
Carpeta=CXC
Clave=EmpresaMFA.AnticiposPagadosPeriodo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco


Tamano=40
[CXP]
Estilo=Ficha
Pestana=S
Clave=CXP
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

PermiteEditar=S
PestanaOtroNombre=S
PestanaNombre=Cxp
[CXP.EmpresaMFA.IncluirNomina]
Carpeta=CXP
Clave=EmpresaMFA.IncluirNomina
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[CXP.EmpresaMFA.CxpAnticiposPagadosPeriodo]
Carpeta=CXP
Clave=EmpresaMFA.CxpAnticiposPagadosPeriodo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco


Tamano=40
[CXC.Columnas]
AnticiposPagadosPeriodo=130

[CXP.Columnas]
IncluirNomina=133
CxpAnticiposPagadosPeriodo=130



















[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S



[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S



[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S



Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
[Acciones.Navegador (Documentos)]
Nombre=Navegador (Documentos)
Boton=0
NombreDesplegar=Navegador (Documentos)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S



















[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=Eliminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S



[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S















[COMS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Compras
Clave=COMS
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
[COMS.EmpresaMFA.COMSCalcularBaseImportacion]
Carpeta=COMS
Clave=EmpresaMFA.COMSCalcularBaseImportacion
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco



























[IFRS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=IFRS
Clave=IFRS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CondicionVisible=EmpresaMFA:EmpresaMFA.IFRS
[IFRS.EmpresaMFA.IncluirPolizasTesoreria]
Carpeta=IFRS
Clave=EmpresaMFA.IncluirPolizasTesoreria
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=25

[DatosGenerales.EmpresaMFA.IFRS]
Carpeta=DatosGenerales
Clave=EmpresaMFA.IFRS
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
ColorFondo=Blanco

















Tamano=35
[IFRS.EmpresaMFA.IncluirPolizasNomina]
Carpeta=IFRS
Clave=EmpresaMFA.IncluirPolizasNomina
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco









[GAS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos
Clave=GAS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[GAS.EmpresaMFA.GASComprobantesPorConcepto]
Carpeta=GAS
Clave=EmpresaMFA.GASComprobantesPorConcepto
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco











[DIN]
Estilo=Ficha
Pestana=S
Clave=DIN
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Tesorería
PermiteEditar=S
Vista=EmpresaMFA
FichaEspacioEntreLineas=6
FichaEspacioNombres=120
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)


[DIN.EmpresaMFA.DINDepositosAnticipados]
Carpeta=DIN
Clave=EmpresaMFA.DINDepositosAnticipados
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=30







[DIN.EmpresaMFA.DINCteDepositosAnticipados]
Carpeta=DIN
Clave=EmpresaMFA.DINCteDepositosAnticipados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[DIN.Cte.Nombre]
Carpeta=DIN
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Blanco















[DIN.EmpresaMFA.DINImpuesto1]
Carpeta=DIN
Clave=EmpresaMFA.DINImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco










[IFRS.EmpresaMFA.IncluirPolizasEspecificas]
Carpeta=IFRS
Clave=EmpresaMFA.IncluirPolizasEspecificas
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco







[Acciones.PolizasEspecificas]
Nombre=PolizasEspecificas
Boton=30
NombreDesplegar=Pólizas Específicas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MFAContAdicion
Activo=S

































EspacioPrevio=S
VisibleCondicion=EmpresaMFA:EmpresaMFA.IFRS y(EmpresaMFA:EmpresaMFA.IncluirPolizasEspecificas)
[Acciones.CuentasEspecificas]
Nombre=CuentasEspecificas
Boton=57
NombreDesplegar=Cuentas Especiales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MFACuentasEspeciales
Activo=S








































































VisibleCondicion=EmpresaMFA:EmpresaMFA.IncluirCuentasEspecificas


[DatosGenerales.EmpresaMFA.IncluirCuentasEspecificas]
Carpeta=DatosGenerales
Clave=EmpresaMFA.IncluirCuentasEspecificas
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco










LineaNueva=S
EspacioPrevio=S
[VTAS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas
Clave=VTAS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaMFA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[VTAS.EmpresaMFA.ImportarFacturasContado]
Carpeta=VTAS
Clave=EmpresaMFA.ImportarFacturasContado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=35








EspacioPrevio=S
[DatosGenerales.EmpresaMFA.ValidarReferencias]
Carpeta=DatosGenerales
Clave=EmpresaMFA.ValidarReferencias
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco





























LineaNueva=S



EspacioPrevio=S




[SIA.EmpresaMFA.BaseDatosSIA]
Carpeta=SIA
Clave=EmpresaMFA.BaseDatosSIA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[SIA.Columnas]
BaseDatosSIA=604



[CXC.EmpresaMFA.CxcChequesDevueltosNegativo]
Carpeta=CXC
Clave=EmpresaMFA.CxcChequesDevueltosNegativo
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco






[CXP.EmpresaMFA.CxpChequesDevueltosNegativo]
Carpeta=CXP
Clave=EmpresaMFA.CxpChequesDevueltosNegativo
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

LineaNueva=S
Tamano=40
[CXC.ListaEnCaptura]
(Inicio)=EmpresaMFA.AnticiposPagadosPeriodo
EmpresaMFA.AnticiposPagadosPeriodo=EmpresaMFA.CxcChequesDevueltosNegativo
EmpresaMFA.CxcChequesDevueltosNegativo=(Fin)

[CXP.ListaEnCaptura]
(Inicio)=EmpresaMFA.IncluirNomina
EmpresaMFA.IncluirNomina=EmpresaMFA.CxpAnticiposPagadosPeriodo
EmpresaMFA.CxpAnticiposPagadosPeriodo=EmpresaMFA.CxpChequesDevueltosNegativo
EmpresaMFA.CxpChequesDevueltosNegativo=(Fin)














[COMS.EmpresaMFA.COMSIVAImportacionAnticipado]
Carpeta=COMS
Clave=EmpresaMFA.COMSIVAImportacionAnticipado
Editar=S
3D=S
Tamano=50
ColorFondo=Blanco

LineaNueva=S


[COMS.ListaEnCaptura]
(Inicio)=EmpresaMFA.COMSCalcularBaseImportacion
EmpresaMFA.COMSCalcularBaseImportacion=EmpresaMFA.COMSIVAImportacionAnticipado
EmpresaMFA.COMSIVAImportacionAnticipado=(Fin)


































































[GAS.ListaEnCaptura]
(Inicio)=EmpresaMFA.GASComprobantesPorConcepto
EmpresaMFA.GASComprobantesPorConcepto=EmpresaMFA.GASPorcentajeDeducible
EmpresaMFA.GASPorcentajeDeducible=(Fin)

[GAS.EmpresaMFA.GASPorcentajeDeducible]
Carpeta=GAS
Clave=EmpresaMFA.GASPorcentajeDeducible
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco




















[IFRS.EmpresaMFA.ExportarSIA]
Carpeta=IFRS
Clave=EmpresaMFA.ExportarSIA
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=25
[IFRS.EmpresaMFA.SIABaseIndependiente]
Carpeta=IFRS
Clave=EmpresaMFA.SIABaseIndependiente
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=25
[IFRS.EmpresaMFA.SIABaseDatos]
Carpeta=IFRS
Clave=EmpresaMFA.SIABaseDatos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco









[IFRS.ListaEnCaptura]
(Inicio)=EmpresaMFA.IncluirPolizasTesoreria
EmpresaMFA.IncluirPolizasTesoreria=EmpresaMFA.IncluirPolizasNomina
EmpresaMFA.IncluirPolizasNomina=EmpresaMFA.IncluirPolizasEspecificas
EmpresaMFA.IncluirPolizasEspecificas=EmpresaMFA.ExportarSIA
EmpresaMFA.ExportarSIA=EmpresaMFA.SIABaseIndependiente
EmpresaMFA.SIABaseIndependiente=EmpresaMFA.SIABaseDatos
EmpresaMFA.SIABaseDatos=(Fin)









[VTAS.EmpresaMFA.IncluirNotas]
Carpeta=VTAS
Clave=EmpresaMFA.IncluirNotas
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco

[VTAS.EmpresaMFA.IncluirNotasAnteriores]
Carpeta=VTAS
Clave=EmpresaMFA.IncluirNotasAnteriores
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco




[VTAS.ListaEnCaptura]
(Inicio)=EmpresaMFA.IncluirNotas
EmpresaMFA.IncluirNotas=EmpresaMFA.IncluirNotasAnteriores
EmpresaMFA.IncluirNotasAnteriores=EmpresaMFA.ImportarFacturasContado
EmpresaMFA.ImportarFacturasContado=(Fin)



[DatosGenerales.ListaEnCaptura]
(Inicio)=EmpresaMFA.Empresa
EmpresaMFA.Empresa=Empresa.Nombre
Empresa.Nombre=EmpresaMFA.Impuesto2
EmpresaMFA.Impuesto2=EmpresaMFA.PeriodoInicial
EmpresaMFA.PeriodoInicial=EmpresaMFA.EjercicioInicial
EmpresaMFA.EjercicioInicial=EmpresaMFA.CobrosConciliados
EmpresaMFA.CobrosConciliados=EmpresaMFA.PagosConciliados
EmpresaMFA.PagosConciliados=EmpresaMFA.IncluirCuentasEspecificas
EmpresaMFA.IncluirCuentasEspecificas=EmpresaMFA.ValidarReferencias
EmpresaMFA.ValidarReferencias=EmpresaMFA.IFRS
EmpresaMFA.IFRS=(Fin)






[DIN.EmpresaMFA.FuncionTesoreria]
Carpeta=DIN
Clave=EmpresaMFA.FuncionTesoreria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Acciones.Tesoreria]
Nombre=Tesoreria
Boton=61
NombreDesplegar=&Claves Tesoreria
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MFAIrTesoreria
Activo=S

















EspacioPrevio=S
VisibleCondicion=EmpresaMFA:EmpresaMFA.FuncionTesoreria
[DIN.ListaEnCaptura]
(Inicio)=EmpresaMFA.DINDepositosAnticipados
EmpresaMFA.DINDepositosAnticipados=EmpresaMFA.DINCteDepositosAnticipados
EmpresaMFA.DINCteDepositosAnticipados=Cte.Nombre
Cte.Nombre=EmpresaMFA.DINImpuesto1
EmpresaMFA.DINImpuesto1=EmpresaMFA.FuncionTesoreria
EmpresaMFA.FuncionTesoreria=(Fin)




































[(Carpeta Abrir).ListaAcciones]
(Inicio)=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)





[Forma.ListaCarpetas]
(Inicio)=DatosGenerales
DatosGenerales=VTAS
VTAS=CXC
CXC=CXP
CXP=COMS
COMS=GAS
GAS=IFRS
IFRS=DIN
DIN=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=PolizasEspecificas
PolizasEspecificas=CuentasEspecificas
CuentasEspecificas=Navegador (Documentos)
Navegador (Documentos)=Cerrar
Cerrar=Tesoreria
Tesoreria=(Fin)
