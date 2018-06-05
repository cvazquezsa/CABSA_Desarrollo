
[Forma]
Clave=PersonalSAT
Icono=4
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Personal
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Detalles
CarpetaPrincipal=Detalles
PosicionInicialIzquierda=373
PosicionInicialArriba=220
PosicionInicialAlturaCliente=248
PosicionInicialAncho=619
ListaAcciones=Guardar
PosicionCol1=315

Comentarios=Info.Personal
[Lista.Columnas]
0=95
1=190
2=-2
3=-2

SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=Personal.Nombre
Personal.Nombre=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Personal.ApellidoMaterno
Personal.ApellidoMaterno=(Fin)

[Detalles]
Estilo=Ficha
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalSAT
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

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaNombre=Datos Generales
FiltroGeneral=Personal.Personal = <T>{Info.Personal}<T>
[Detalles.Personal.Direccion]
Carpeta=Detalles
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco

[Detalles.Personal.DireccionNumero]
Carpeta=Detalles
Clave=Personal.DireccionNumero
Editar=S
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalles.Personal.DireccionNumeroInt]
Carpeta=Detalles
Clave=Personal.DireccionNumeroInt
Editar=S
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalles.Personal.EntreCalles]
Carpeta=Detalles
Clave=Personal.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.Personal.Plano]
Carpeta=Detalles
Clave=Personal.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.Personal.Delegacion]
Carpeta=Detalles
Clave=Personal.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.Personal.Colonia]
Carpeta=Detalles
Clave=Personal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.Personal.CodigoPostal]
Carpeta=Detalles
Clave=Personal.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.Personal.Poblacion]
Carpeta=Detalles
Clave=Personal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.Personal.Estado]
Carpeta=Detalles
Clave=Personal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.Personal.Pais]
Carpeta=Detalles
Clave=Personal.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco











[Detalles.Personal.Observaciones]
Carpeta=Detalles
Clave=Personal.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[Detalles.Personal.Personal]
Carpeta=Detalles
Clave=Personal.Personal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Detalles.NombreCompleto]
Carpeta=Detalles
Clave=NombreCompleto
ValidaNombre=N
3D=S
Tamano=53
ColorFondo=Plata

Pegado=S








[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)













[Detalles.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.Direccion
Personal.Direccion=Personal.DireccionNumero
Personal.DireccionNumero=Personal.DireccionNumeroInt
Personal.DireccionNumeroInt=Personal.EntreCalles
Personal.EntreCalles=Personal.Plano
Personal.Plano=Personal.Observaciones
Personal.Observaciones=Personal.Delegacion
Personal.Delegacion=Personal.Colonia
Personal.Colonia=Personal.CodigoPostal
Personal.CodigoPostal=Personal.Poblacion
Personal.Poblacion=Personal.Estado
Personal.Estado=Personal.Pais
Personal.Pais=(Fin)
