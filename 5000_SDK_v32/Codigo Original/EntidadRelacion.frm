
[Forma]
Clave=EntidadRelacion
Icono=0
Modulos=(Todos)
Nombre=Relaciones de la Entidad

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=280
PosicionInicialArriba=185
PosicionInicialAlturaCliente=362
PosicionInicialAncho=805
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Entidad, Info.Nombre)
PosicionCol1=546
PosicionSec1=276
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S




HojaMantenerSeleccion=S
FiltroGeneral=EntidadRelacion.Entidad=<T>{Info.Entidad}<T>
[Lista.Columnas]
EntidadRelacion=124
Nombre=293
TipoRelacion=104

Tipo=191
0=106
1=301
2=-2
Clave=68
ContactoTipo=80
Observaciones=177
Cliente=117
RFC=107
Estatus=82
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Cte]
Estilo=Ficha
PestanaNombre=Cliente
Clave=Cte
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
Pestana=S
CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Cliente<T>
[Cte.EntidadRelacion.Cliente]
Carpeta=Cte
Clave=EntidadRelacion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cte.Cte.Nombre]
Carpeta=Cte
Clave=Cte.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata













[Prov]
Estilo=Ficha
Clave=Prov
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
PestanaNombre=Proveedor
Pestana=S
CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Proveedor<T>
[Prov.EntidadRelacion.Proveedor]
Carpeta=Prov
Clave=EntidadRelacion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prov.Prov.Nombre]
Carpeta=Prov
Clave=Prov.Nombre
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata







LineaNueva=S







[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S



ConfirmarAntes=S






[Prospecto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Prospecto
Clave=Prospecto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Prospecto<T>
[Prospecto.EntidadRelacion.Prospecto]
Carpeta=Prospecto
Clave=EntidadRelacion.Prospecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Personal.Nombre]
Carpeta=Prospecto
Clave=Personal.Nombre
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

LineaNueva=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S






[Agente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agente
Clave=Agente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Agente<T>
[Agente.EntidadRelacion.Agente]
Carpeta=Agente
Clave=EntidadRelacion.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Agente.Agente.Nombre]
Carpeta=Agente
Clave=Agente.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata




[Personal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Personal
Clave=Personal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Personal<T>
[Personal.EntidadRelacion.Personal]
Carpeta=Personal
Clave=EntidadRelacion.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.Personal.ApellidoPaterno]
Carpeta=Personal
Clave=Personal.ApellidoPaterno
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

[Personal.Personal.ApellidoMaterno]
Carpeta=Personal
Clave=Personal.ApellidoMaterno
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

[Personal.Personal.Nombre]
Carpeta=Personal
Clave=Personal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata






[Cte.Cte.Tipo]
Carpeta=Cte
Clave=Cte.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Prov.Prov.Tipo]
Carpeta=Prov
Clave=Prov.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Prospecto.Prospecto.Tipo]
Carpeta=Prospecto
Clave=Prospecto.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Agente.Agente.Tipo]
Carpeta=Agente
Clave=Agente.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Personal.Personal.Tipo]
Carpeta=Personal
Clave=Personal.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata





[Entidad]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Entidad
Clave=Entidad
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Entidad<T>
[Entidad.EntidadRelacion.EntidadDestino]
Carpeta=Entidad
Clave=EntidadRelacion.EntidadDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[VIN]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=VIN
Clave=VIN
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>VIN<T>
[VIN.EntidadRelacion.VIN]
Carpeta=VIN
Clave=EntidadRelacion.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[VIN.VIN.Articulo]
Carpeta=VIN
Clave=VIN.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Espacio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Espacio
Clave=Espacio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Espacio<T>
[Espacio.EntidadRelacion.Espacio]
Carpeta=Espacio
Clave=EntidadRelacion.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Espacio.Espacio.Nombre]
Carpeta=Espacio
Clave=Espacio.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

[Espacio.Espacio.Tipo]
Carpeta=Espacio
Clave=Espacio.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


[Recurso]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recurso
Clave=Recurso
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Recurso<T>
[Recurso.EntidadRelacion.Recurso]
Carpeta=Recurso
Clave=EntidadRelacion.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Recurso.Recurso.Nombre]
Carpeta=Recurso
Clave=Recurso.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata



[Lista.Clave]
Carpeta=Lista
Clave=Clave
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









ColorFuente=Gris
[Lista.EntidadRelacion.ContactoTipo]
Carpeta=Lista
Clave=EntidadRelacion.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.EntidadRelacion.TipoRelacion]
Carpeta=Lista
Clave=EntidadRelacion.TipoRelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EntidadRelacion.Observaciones]
Carpeta=Lista
Clave=EntidadRelacion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Prov.ListaEnCaptura]
(Inicio)=EntidadRelacion.Proveedor
EntidadRelacion.Proveedor=Prov.Nombre
Prov.Nombre=Prov.Tipo
Prov.Tipo=(Fin)

[Prospecto.ListaEnCaptura]
(Inicio)=EntidadRelacion.Prospecto
EntidadRelacion.Prospecto=Personal.Nombre
Personal.Nombre=Prospecto.Tipo
Prospecto.Tipo=(Fin)

[Agente.ListaEnCaptura]
(Inicio)=EntidadRelacion.Agente
EntidadRelacion.Agente=Agente.Nombre
Agente.Nombre=Agente.Tipo
Agente.Tipo=(Fin)

[Personal.ListaEnCaptura]
(Inicio)=EntidadRelacion.Personal
EntidadRelacion.Personal=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Personal.ApellidoMaterno
Personal.ApellidoMaterno=Personal.Nombre
Personal.Nombre=Personal.Tipo
Personal.Tipo=(Fin)

[VIN.ListaEnCaptura]
(Inicio)=EntidadRelacion.VIN
EntidadRelacion.VIN=VIN.Articulo
VIN.Articulo=(Fin)

[Espacio.ListaEnCaptura]
(Inicio)=EntidadRelacion.Espacio
EntidadRelacion.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Tipo
Espacio.Tipo=(Fin)




[Recurso.ListaEnCaptura]
(Inicio)=EntidadRelacion.Recurso
EntidadRelacion.Recurso=Recurso.Nombre
Recurso.Nombre=(Fin)



[Usuario]
Estilo=Ficha
Pestana=S
Clave=Usuario
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EntidadRelacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

PestanaOtroNombre=S
PestanaNombre=Usuario

CondicionVisible=EntidadRelacion:EntidadRelacion.ContactoTipo=<T>Usuario<T>
[Usuario.EntidadRelacion.Usuario]
Carpeta=Usuario
Clave=EntidadRelacion.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Usuario.Usuario.Nombre]
Carpeta=Usuario
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata



[Usuario.ListaEnCaptura]
(Inicio)=EntidadRelacion.Usuario
EntidadRelacion.Usuario=Usuario.Nombre
Usuario.Nombre=(Fin)

















[Lista.ListaEnCaptura]
(Inicio)=EntidadRelacion.ContactoTipo
EntidadRelacion.ContactoTipo=Clave
Clave=EntidadRelacion.TipoRelacion
EntidadRelacion.TipoRelacion=EntidadRelacion.Observaciones
EntidadRelacion.Observaciones=EntidadRelacion.Estatus
EntidadRelacion.Estatus=(Fin)

[Lista.EntidadRelacion.Estatus]
Carpeta=Lista
Clave=EntidadRelacion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco










[Entidad.EntidadDestino.Nombre]
Carpeta=Entidad
Clave=EntidadDestino.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata



[Entidad.EntidadDestino.Tipo]
Carpeta=Entidad
Clave=EntidadDestino.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

[Cte.ListaEnCaptura]
(Inicio)=EntidadRelacion.Cliente
EntidadRelacion.Cliente=Cte.Nombre
Cte.Nombre=Cte.Tipo
Cte.Tipo=(Fin)

[Entidad.ListaEnCaptura]
(Inicio)=EntidadRelacion.EntidadDestino
EntidadRelacion.EntidadDestino=EntidadDestino.Nombre
EntidadDestino.Nombre=EntidadDestino.Tipo
EntidadDestino.Tipo=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Entidad
Entidad=Cte
Cte=Prov
Prov=Prospecto
Prospecto=Agente
Agente=Personal
Personal=VIN
VIN=Espacio
Espacio=Recurso
Recurso=Usuario
Usuario=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
