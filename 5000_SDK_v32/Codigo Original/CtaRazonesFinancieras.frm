
[Forma]
Clave=CtaRazonesFinancieras
Icono=0
CarpetaPrincipal=CtaRazonesFinancieras
Modulos=(Todos)
Nombre=Cuentas Razones Financieras - Configurar

ListaCarpetas=(Lista)
PosicionInicialIzquierda=374
PosicionInicialArriba=96
PosicionInicialAlturaCliente=523
PosicionInicialAncho=751
PosicionSec1=71
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
BarraAcciones=S
ListaAcciones=(Lista)
PosicionCol2=361
[CtaRazonesFinancieras]
Estilo=Ficha
Clave=CtaRazonesFinancieras
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaRazonesFinancieras
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

[CtaRazonesFinancieras.CtaRazonesFinancieras.Cuenta]
Carpeta=CtaRazonesFinancieras
Clave=CtaRazonesFinancieras.Cuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Editar=S
[CtaRazonesFinancieras.CtaRazonesFinancieras.Descripcion]
Carpeta=CtaRazonesFinancieras
Clave=CtaRazonesFinancieras.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[CtaRazonesFinancierasAdicionar]
Estilo=Hoja
Clave=CtaRazonesFinancierasAdicionar
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CtaRazonesFinancierasAdicionar
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CtaRazonesFinancieras
LlaveLocal=CtaRazonesFinancierasAdicionar.Cuenta
LlaveMaestra=CtaRazonesFinancieras.Cuenta
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Adicionar
[CtaRazonesFinancierasAdicionar.CtaRazonesFinancierasAdicionar.CuentaA]
Carpeta=CtaRazonesFinancierasAdicionar
Clave=CtaRazonesFinancierasAdicionar.CuentaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[CtaRazonesFinancierasAdicionar.Columnas]
CuentaA=94




Descripcion=224
[(Carpeta Abrir)]
Estilo=Iconos
Pestana=S
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CtaRazonesFinancierasA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S

IconosSubTitulo=<T>Cuenta<T>


ListaEnCaptura=CtaRazonesFinancieras.Descripcion
PestanaOtroNombre=S
PestanaNombre=Cuentas Razones Financieras - Configurar
IconosConPaginas=S
IconosNombre=CtaRazonesFinancierasA:CtaRazonesFinancieras.Cuenta
[(Carpeta Abrir).Columnas]
0=116
1=386








2=-2










[(Carpeta Abrir).CtaRazonesFinancieras.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=CtaRazonesFinancieras.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=CtaRazonesFinancieras.Cuenta
CtaRazonesFinancieras.Cuenta=CtaRazonesFinancieras.Descripcion
CtaRazonesFinancieras.Descripcion=(Fin)






















[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S




EspacioPrevio=S
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

NombreEnBoton=S









EspacioPrevio=S
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


















[CtaRazonesFinancierasAdicionar.Descripcion]
Carpeta=CtaRazonesFinancierasAdicionar
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco















[Lista.Columnas]
0=207








[CtaRazonesFinancierasExcepcionar.CtaRazonesFinancierasExcepcionar.CuentaE]
Carpeta=CtaRazonesFinancierasExcepcionar
Clave=CtaRazonesFinancierasExcepcionar.CuentaE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[CtaRazonesFinancierasExcepcionar.Descripcion]
Carpeta=CtaRazonesFinancierasExcepcionar
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[CtaRazonesFinancierasExcepcionar.Columnas]
CuentaE=109
Descripcion=219




[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreEnBoton=S
NombreDesplegar=Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S











EspacioPrevio=S























[CtaRazonesFinancieras.ListaEnCaptura]
(Inicio)=CtaRazonesFinancieras.Cuenta
CtaRazonesFinancieras.Cuenta=CtaRazonesFinancieras.Descripcion
CtaRazonesFinancieras.Descripcion=(Fin)











[CtaRazonesFinancierasExcepcionar]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Excepcionar
Clave=CtaRazonesFinancierasExcepcionar
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=CtaRazonesFinancierasExcepcionar
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CtaRazonesFinancieras
LlaveLocal=CtaRazonesFinancierasExcepcionar.Cuenta
LlaveMaestra=CtaRazonesFinancieras.Cuenta
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Pestana=S

[CtaRazonesFinancierasExcepcionar.ListaEnCaptura]
(Inicio)=CtaRazonesFinancierasExcepcionar.CuentaE
CtaRazonesFinancierasExcepcionar.CuentaE=Descripcion
Descripcion=(Fin)











[CtaRazonesFinancierasAdicionar.ListaEnCaptura]
(Inicio)=CtaRazonesFinancierasAdicionar.CuentaA
CtaRazonesFinancierasAdicionar.CuentaA=Descripcion
Descripcion=(Fin)















































[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=Eliminar
EnBarraHerramientas=S
TipoAccion=controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S























































































































































GuardarConfirmar=S






























[Forma.ListaCarpetas]
(Inicio)=CtaRazonesFinancieras
CtaRazonesFinancieras=CtaRazonesFinancierasAdicionar
CtaRazonesFinancierasAdicionar=CtaRazonesFinancierasExcepcionar
CtaRazonesFinancierasExcepcionar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Abrir
Abrir=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
