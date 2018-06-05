[Forma]
Clave=Recurso
Nombre=Recursos
Icono=4
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=369
PosicionInicialArriba=108
PosicionInicialAlturaCliente=492
PosicionInicialAncho=745
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=396
PosicionSec1=367
DialogoAbrir=S
Menus=S

MenuPrincipal=(Lista)
[Lista.Recurso.Recurso]
Carpeta=Lista
Clave=Recurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Nombre]
Carpeta=Lista
Clave=Recurso.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Estatus]
Carpeta=Lista
Clave=Recurso.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Grupo]
Carpeta=Lista
Clave=Recurso.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Recurso=68
Nombre=201
Personal=64
Agente=64
Usuario=57
Estatus=56
Grupo=152
eMail=134
NombreExchange=136

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=RecursoGrupo
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar ...
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
Menu=&Archivo
EnMenu=S

ConCondicion=S
ActivoCondicion=no Recurso:Recurso.TieneMovimientos
EjecucionCondicion=Forma.ActualizarVista<BR>Forma.ActualizarControles<BR>Si                     <BR> Recurso:Recurso.TieneMovimientos<BR>Entonces<BR>  Error(<T>El recurso ya tiene movimientos activos<T> , BotonAceptar  )<BR>Fin
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Recurso
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

[Ficha.Recurso.Personal]
Carpeta=Ficha
Clave=Recurso.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalNombre]
Carpeta=Ficha
Clave=PersonalNombre
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Recurso.Agente]
Carpeta=Ficha
Clave=Recurso.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Recurso.Usuario]
Carpeta=Ficha
Clave=Recurso.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Personal.eMail]
Carpeta=Ficha
Clave=Personal.eMail
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Agente.eMail]
Carpeta=Ficha
Clave=Agente.eMail
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Ficha.Usuario.eMail]
Carpeta=Ficha
Clave=Usuario.eMail
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.Recurso.NombreExchange]
Carpeta=Lista
Clave=Recurso.NombreExchange
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.Prospecto]
Carpeta=Ficha
Clave=Recurso.Prospecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Recurso.Cliente]
Carpeta=Ficha
Clave=Recurso.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.Proveedor]
Carpeta=Ficha
Clave=Recurso.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Cte.eMail1]
Carpeta=Ficha
Clave=Cte.eMail1
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Prov.eMail1]
Carpeta=Ficha
Clave=Prov.eMail1
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Doc]
Nombre=Doc
Boton=17
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Menu=&Edición
EnMenu=S
Expresion=EditarDocumentacion(<T>RES<T>, Recurso:Recurso.Recurso, <T>Documentación - <T>+Recurso:Recurso.Nombre)
EjecucionCondicion=ConDatos(Recurso:Recurso.Recurso)

[Ficha.Prospecto.Nombre]
Carpeta=Ficha
Clave=Prospecto.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Recurso.AFArticulo]
Carpeta=Ficha
Clave=Recurso.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Recurso.AFSerie]
Carpeta=Ficha
Clave=Recurso.AFSerie
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.Recurso]
Carpeta=Ficha
Clave=Recurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.Nombre]
Carpeta=Ficha
Clave=Recurso.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=43
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Recurso.Estatus]
Carpeta=Ficha
Clave=Recurso.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.eMail]
Carpeta=Ficha
Clave=Recurso.eMail
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=43
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Recurso.Grupo]
Carpeta=Ficha
Clave=Recurso.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.NombreExchange]
Carpeta=Ficha
Clave=Recurso.NombreExchange
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=RecursoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Recurso<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Recurso.Nombre
ListaOrden=Recurso.Recurso<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=RecursoGrupo
FiltroAplicaEn1=Recurso.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S

IconosConPaginas=S
IconosNombre=RecursoA:Recurso.Recurso
[(Carpeta Abrir).Recurso.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Recurso.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=122
1=435

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

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=Abrir
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Excel]
Nombre=Excel
Boton=0
Menu=&Archivo
NombreDesplegar=Excel ...
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Ficha.Recurso.Rol]
Carpeta=Ficha
Clave=Recurso.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.HorasDia]
Carpeta=Ficha
Clave=Recurso.HorasDia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.PrecioHora]
Carpeta=Ficha
Clave=Recurso.PrecioHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Recurso.CostoHora]
Carpeta=Ficha
Clave=Recurso.CostoHora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Ficha.ListaEnCaptura]
(Inicio)=Recurso.Recurso
Recurso.Recurso=Recurso.Nombre
Recurso.Nombre=Recurso.NombreExchange
Recurso.NombreExchange=Recurso.eMail
Recurso.eMail=Recurso.Grupo
Recurso.Grupo=Recurso.Estatus
Recurso.Estatus=Recurso.Usuario
Recurso.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.eMail
Usuario.eMail=Recurso.Prospecto
Recurso.Prospecto=Prospecto.Nombre
Prospecto.Nombre=Recurso.Cliente
Recurso.Cliente=Cte.Nombre
Cte.Nombre=Cte.eMail1
Cte.eMail1=Recurso.Proveedor
Recurso.Proveedor=Prov.Nombre
Prov.Nombre=Prov.eMail1
Prov.eMail1=Recurso.Personal
Recurso.Personal=PersonalNombre
PersonalNombre=Personal.eMail
Personal.eMail=Recurso.Agente
Recurso.Agente=Agente.Nombre
Agente.Nombre=Agente.eMail
Agente.eMail=Recurso.AFArticulo
Recurso.AFArticulo=Art.Descripcion1
Art.Descripcion1=Recurso.AFSerie
Recurso.AFSerie=Recurso.Rol
Recurso.Rol=Recurso.HorasDia
Recurso.HorasDia=Recurso.PrecioHora
Recurso.PrecioHora=Recurso.CostoHora
Recurso.CostoHora=(Fin)













[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar Cambios
Guardar Cambios=Eliminar
Eliminar=Grupos
Grupos=Doc
Doc=Navegador
Navegador=Excel
Excel=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Maestros
&Maestros=(Fin)
