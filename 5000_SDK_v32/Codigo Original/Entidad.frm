[Forma]
Clave=Entidad
Icono=0
Modulos=(Todos)
Nombre=Entidades

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=334
PosicionInicialArriba=113
PosicionInicialAlturaCliente=505
PosicionInicialAncho=697
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
DialogoAbrir=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Menus=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.SubCatalogo, <T>ENT<T>)
PosicionSec1=318
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Entidad
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

[Ficha.Entidad.Entidad]
Carpeta=Ficha
Clave=Entidad.Entidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

Efectos=[Negritas]
[Ficha.Entidad.Nombre]
Carpeta=Ficha
Clave=Entidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=74
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.Entidad.Tipo]
Carpeta=Ficha
Clave=Entidad.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Entidad.Estatus]
Carpeta=Ficha
Clave=Entidad.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Entidades
Clave=(Carpeta Abrir)
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EntidadA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroEstatus=S
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
CarpetaVisible=S

FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroUsuarios=S
Filtros=S
IconosNombre=EntidadA:Entidad.Entidad
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Entidad.SubCatalogo=<T>{Info.SubCatalogo}<T>
FiltroRespetar=S
FiltroTipo=General
[(Carpeta Abrir).Entidad.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Entidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).Entidad.Tipo]
Carpeta=(Carpeta Abrir)
Clave=Entidad.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[(Carpeta Abrir).Columnas]
0=74
1=445
2=138





[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S


[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S









[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S







[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
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
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=<T>&Cerrar<T>
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S















[Fiscal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fiscal
Clave=Fiscal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Entidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Fiscal.Entidad.Entidad]
Carpeta=Fiscal
Clave=Entidad.Entidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

Efectos=[Negritas]
[Fiscal.Entidad.Nombre]
Carpeta=Fiscal
Clave=Entidad.Nombre
Editar=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata

Efectos=[Negritas]
[Fiscal.Entidad.Registro1]
Carpeta=Fiscal
Clave=Entidad.Registro1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Entidad.Registro2]
Carpeta=Fiscal
Clave=Entidad.Registro2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Entidad.Registro3]
Carpeta=Fiscal
Clave=Entidad.Registro3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco












[Direccion.Entidad.Entidad]
Carpeta=Direccion
Clave=Entidad.Entidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

Efectos=[Negritas]
[Direccion.Entidad.Nombre]
Carpeta=Direccion
Clave=Entidad.Nombre
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata

LineaNueva=N
Efectos=[Negritas]
[Direccion.Entidad.Direccion]
Carpeta=Direccion
Clave=Entidad.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=53
ColorFondo=Blanco

[Direccion.Entidad.DireccionNumero]
Carpeta=Direccion
Clave=Entidad.DireccionNumero
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=S
[Direccion.Entidad.DireccionNumeroInt]
Carpeta=Direccion
Clave=Entidad.DireccionNumeroInt
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=S
[Direccion.Entidad.EntreCalles]
Carpeta=Direccion
Clave=Entidad.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Plano]
Carpeta=Direccion
Clave=Entidad.Plano
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Observaciones]
Carpeta=Direccion
Clave=Entidad.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Delegacion]
Carpeta=Direccion
Clave=Entidad.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.CodigoPostal]
Carpeta=Direccion
Clave=Entidad.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Colonia]
Carpeta=Direccion
Clave=Entidad.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Poblacion]
Carpeta=Direccion
Clave=Entidad.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Estado]
Carpeta=Direccion
Clave=Entidad.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.Entidad.Pais]
Carpeta=Direccion
Clave=Entidad.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dirección
Clave=Direccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Entidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S












[Contacto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contacto
Clave=Contacto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Entidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Contacto.Entidad.Entidad]
Carpeta=Contacto
Clave=Entidad.Entidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
Efectos=[Negritas]

[Contacto.Entidad.Nombre]
Carpeta=Contacto
Clave=Entidad.Nombre
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
Efectos=[Negritas]


[Direccion.ListaEnCaptura]
(Inicio)=Entidad.Entidad
Entidad.Entidad=Entidad.Nombre
Entidad.Nombre=Entidad.Direccion
Entidad.Direccion=Entidad.DireccionNumero
Entidad.DireccionNumero=Entidad.DireccionNumeroInt
Entidad.DireccionNumeroInt=Entidad.EntreCalles
Entidad.EntreCalles=Entidad.Plano
Entidad.Plano=Entidad.Observaciones
Entidad.Observaciones=Entidad.Delegacion
Entidad.Delegacion=Entidad.Colonia
Entidad.Colonia=Entidad.CodigoPostal
Entidad.CodigoPostal=Entidad.Poblacion
Entidad.Poblacion=Entidad.Estado
Entidad.Estado=Entidad.Pais
Entidad.Pais=(Fin)

[Fiscal.ListaEnCaptura]
(Inicio)=Entidad.Entidad
Entidad.Entidad=Entidad.Nombre
Entidad.Nombre=Entidad.Registro1
Entidad.Registro1=Entidad.Registro2
Entidad.Registro2=Entidad.Registro3
Entidad.Registro3=(Fin)





[Contacto.Entidad.CorreoEletronico1]
Carpeta=Contacto
Clave=Entidad.CorreoEletronico1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.CorreoEletronico2]
Carpeta=Contacto
Clave=Entidad.CorreoEletronico2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.CorreoEletronico3]
Carpeta=Contacto
Clave=Entidad.CorreoEletronico3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.PaginaWeb]
Carpeta=Contacto
Clave=Entidad.PaginaWeb
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.Telefonos1]
Carpeta=Contacto
Clave=Entidad.Telefonos1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.Telefonos2]
Carpeta=Contacto
Clave=Entidad.Telefonos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.Telefonos3]
Carpeta=Contacto
Clave=Entidad.Telefonos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.Telefonos4]
Carpeta=Contacto
Clave=Entidad.Telefonos4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Contacto.Entidad.Fax]
Carpeta=Contacto
Clave=Entidad.Fax
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

ValidaNombre=S
[Contacto.Entidad.PedirTono]
Carpeta=Contacto
Clave=Entidad.PedirTono
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco








[Contacto.ListaEnCaptura]
(Inicio)=Entidad.Entidad
Entidad.Entidad=Entidad.Nombre
Entidad.Nombre=Entidad.CorreoEletronico1
Entidad.CorreoEletronico1=Entidad.CorreoEletronico2
Entidad.CorreoEletronico2=Entidad.CorreoEletronico3
Entidad.CorreoEletronico3=Entidad.PaginaWeb
Entidad.PaginaWeb=Entidad.Telefonos1
Entidad.Telefonos1=Entidad.Telefonos2
Entidad.Telefonos2=Entidad.Telefonos3
Entidad.Telefonos3=Entidad.Telefonos4
Entidad.Telefonos4=Entidad.Fax
Entidad.Fax=Entidad.PedirTono
Entidad.PedirTono=(Fin)

















[Ficha.Entidad.Nombres]
Carpeta=Ficha
Clave=Entidad.Nombres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.Entidad.ApellidoPaterno]
Carpeta=Ficha
Clave=Entidad.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Entidad.ApellidoMaterno]
Carpeta=Ficha
Clave=Entidad.ApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

















[Lista.Columnas]
Estado=150
Delegacion=129
Colonia=189
CodigoPostal=71
Ruta=67











[Ficha.ListaEnCaptura]
(Inicio)=Entidad.Entidad
Entidad.Entidad=Entidad.Tipo
Entidad.Tipo=Entidad.Estatus
Entidad.Estatus=Entidad.Nombres
Entidad.Nombres=Entidad.ApellidoPaterno
Entidad.ApellidoPaterno=Entidad.ApellidoMaterno
Entidad.ApellidoMaterno=Entidad.Organizacion
Entidad.Organizacion=Entidad.Cargo
Entidad.Cargo=Entidad.Nombre
Entidad.Nombre=(Fin)

[Ficha.Entidad.Organizacion]
Carpeta=Ficha
Clave=Entidad.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Entidad.Cargo]
Carpeta=Ficha
Clave=Entidad.Cargo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Entidad.Nombre
Entidad.Nombre=Entidad.Tipo
Entidad.Tipo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)














































[Acciones.EntidadRelacion]
Nombre=EntidadRelacion
Boton=16
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
NombreDesplegar=&Relaciones
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EntidadRelacion
Activo=S
ConCondicion=S
Antes=S
Visible=S







EspacioPrevio=S












EjecucionCondicion=ConDatos(Entidad:Entidad.Entidad)
AntesExpresiones=Asigna(Info.Entidad, Entidad:Entidad.Entidad)<BR>Asigna(Info.Nombre, Entidad:Entidad.Nombre)






















[Posiciones.Columnas]
0=66
1=375
2=157

[Posiciones.ListaEnCaptura]
(Inicio)=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=EntidadPosicion.Rol
EntidadPosicion.Rol=(Fin)



















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







[Posicion]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Posiciones
Clave=Posicion
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=EntidadPosicion
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Entidad
LlaveLocal=EntidadPosicion.Entidad
LlaveMaestra=Entidad.Entidad
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Posición<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
MenuLocal=S

ListaAcciones=PosicionPersonalizar
Filtros=S
IconosNombre=EntidadPosicion:EntidadPosicion.Posicion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=EntidadPosicion.Estatus=<T>ALTA<T>
FiltroRespetar=S
FiltroTipo=General
[Posicion.OrganizacionPosicion.Nombre]
Carpeta=Posicion
Clave=OrganizacionPosicion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Posicion.EntidadPosicion.Rol]
Carpeta=Posicion
Clave=EntidadPosicion.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Acciones.PosicionPersonalizar]
Nombre=PosicionPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Posicion
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Posicion.Columnas]
0=108
1=292
2=129




















3=120

[Posicion.Organizacion.Nombre]
Carpeta=Posicion
Clave=Organizacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

















































[Posicion.ListaEnCaptura]
(Inicio)=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=EntidadPosicion.Rol
EntidadPosicion.Rol=Organizacion.Nombre
Organizacion.Nombre=(Fin)
















[Acciones.EntidadTipoRelacion]
Nombre=EntidadTipoRelacion
Boton=0
Menu=&Maestros
NombreDesplegar=&Tipos Relaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=EntidadTipoRelacion
Activo=S
Visible=S










[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Direccion
Direccion=Contacto
Contacto=Fiscal
Fiscal=Posicion
Posicion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Cerrar
Cerrar=EntidadTipoRelacion
EntidadTipoRelacion=EntidadRelacion
EntidadRelacion=Navegador
Navegador=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
