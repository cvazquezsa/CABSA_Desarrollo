
[Forma]
Clave=ContParalelaEmpresa
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Empresas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=398
PosicionInicialArriba=236
PosicionInicialAlturaCliente=218
PosicionInicialAncho=569

Menus=S
DialogoAbrir=S
MenuPrincipal=&Archivo
[Lista]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Empresa
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaEmpresa
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
ListaEnCaptura=(Lista)

ListaOrden=ContParalelaEmpresa.Empresa<TAB>(Acendente)
CarpetaVisible=S
PermiteEditar=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Lista.ContParalelaEmpresa.Empresa]
Carpeta=Lista
Clave=ContParalelaEmpresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ContParalelaEmpresa.BaseDatosRemota]
Carpeta=Lista
Clave=ContParalelaEmpresa.BaseDatosRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.ContParalelaEmpresa.EmpresaRemota]
Carpeta=Lista
Clave=ContParalelaEmpresa.EmpresaRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.Columnas]
Empresa=75
BaseDatosRemota=145
EmpresaRemota=105

Nombre=371












[Lista.ListaEnCaptura]
(Inicio)=ContParalelaEmpresa.Empresa
ContParalelaEmpresa.Empresa=Empresa.Nombre
Empresa.Nombre=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
3D=S
Pegado=S
Tamano=50
ColorFondo=$00F0F0F0
Efectos=[Negritas]

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S

UsaTeclaRapida=S
TeclaRapida=Ctrl+N
[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S


Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
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



[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S




ActivoCondicion=no(ContParalelaEmpresa:ContParalelaEmpresa.TieneMovimientos)
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S




[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ContParalelaEmpresaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Empresa<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=ContParalelaEmpresa.ID<TAB>(Acendente)
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
IconosNombre=ContParalelaEmpresaA:ContParalelaEmpresa.Empresa
[(Carpeta Abrir).ContParalelaEmpresa.BaseDatosRemota]
Carpeta=(Carpeta Abrir)
Clave=ContParalelaEmpresa.BaseDatosRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[(Carpeta Abrir).ContParalelaEmpresa.EmpresaRemota]
Carpeta=(Carpeta Abrir)
Clave=ContParalelaEmpresa.EmpresaRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[(Carpeta Abrir).Columnas]
0=82
1=149
2=187
3=117












[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)



[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Navegador
Navegador=(Fin)
