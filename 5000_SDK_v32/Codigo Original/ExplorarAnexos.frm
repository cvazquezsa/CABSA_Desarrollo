[Forma]
Clave=ExplorarAnexos
Icono=4
Modulos=(Todos)
Nombre=Explorando - Anexos
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=416
PosicionInicialArriba=347
PosicionInicialAlturaCliente=469
PosicionInicialAncho=1087
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerAnexo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=VerAnexo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
IconosSubTitulo=<T>Clave<T>
ListaEnCaptura=(Lista)
FiltroFechas=S
FiltroFechasCampo=VerAnexo.Vencimiento
FiltroFechasDefault=Vencido
FiltroFechasVencimiento=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=Examinar
IconosNombre=Si(Vacio(VerAnexo:VerAnexo.Cuenta), VerAnexo:VerAnexo.Mov+<T> <T>+VerAnexo:VerAnexo.MovID, VerAnexo:VerAnexo.Cuenta)

[Lista.VerAnexo.Nombre]
Carpeta=Lista
Clave=VerAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAnexo.Tipo]
Carpeta=Lista
Clave=VerAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAnexo.Vencimiento]
Carpeta=Lista
Clave=VerAnexo.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAnexo.Categoria]
Carpeta=Lista
Clave=VerAnexo.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAnexo.Grupo]
Carpeta=Lista
Clave=VerAnexo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAnexo.Familia]
Carpeta=Lista
Clave=VerAnexo.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=109
1=146

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
Expresion=Si<BR>  VerAnexo:VerAnexo.AnexoTipo=<T>Movimiento<T><BR>Entonces<BR>  Asigna(Info.Modulo, VerAnexo:VerAnexo.Modulo)<BR>  Asigna(Info.ID, VerAnexo:VerAnexo.ModuloID)<BR>  Forma(<T>MovPropiedades<T>)<BR>Sino<BR>  Caso VerAnexo:VerAnexo.Catalogo<BR>    Es <T>Cliente<T>   Entonces Asigna(Info.Cliente, VerAnexo:VerAnexo.Cuenta) Forma(<T>CteInfo<T>)<BR>    Es <T>Proveedor<T> Entonces Asigna(Info.Proveedor, VerAnexo:VerAnexo.Cuenta) Forma(<T>ProvInfo<T>)<BR>    Es <T>Personal<T>  Entonces Asigna(Info.Personal, VerAnexo:VerAnexo.Cuenta) Forma(<T>PersonalInfo<T>)<BR>    Es <T>Agente<T>    Entonces Asigna(Info.Agente, VerAnexo:VerAnexo.Cuenta) Forma(<T>AgenteInfo<T>)<BR>  Fin<BR>Fin

[Lista.VerAnexo.FechaEmision]
Carpeta=Lista
Clave=VerAnexo.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Examinar]
Nombre=Examinar
Boton=0
NombreDesplegar=&Examinar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Caso VerAnexo:VerAnexo.Tipo<BR>  Es <T>Comentario<T> Entonces VerComentario(VerAnexo:VerAnexo.Nombre, VerAnexo:VerAnexo.Comentario)<BR>  Es <T>Mensaje<T>    Entonces VerComentario(VerAnexo:VerAnexo.Nombre, VerAnexo:VerAnexo.Comentario)<BR>  Es <T>Imagen<T>     Entonces VerImagen(VerAnexo:VerAnexo.Nombre, VerAnexo:VerAnexo.Direccion)<BR>Sino<BR>  URL(VerAnexo:VerAnexo.Direccion)<BR>Fin

[Acciones.Cambiar Estilo (Iconos)]
Nombre=Cambiar Estilo (Iconos)
Boton=0
NombreDesplegar=Cambiar Estilo (Iconos)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Info
Info=Cambiar Estilo (Iconos)
Cambiar Estilo (Iconos)=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerAnexo.Nombre
VerAnexo.Nombre=VerAnexo.Tipo
VerAnexo.Tipo=VerAnexo.FechaEmision
VerAnexo.FechaEmision=VerAnexo.Vencimiento
VerAnexo.Vencimiento=VerAnexo.Categoria
VerAnexo.Categoria=VerAnexo.Grupo
VerAnexo.Grupo=VerAnexo.Familia
VerAnexo.Familia=(Fin)
